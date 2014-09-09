require 'rails_helper'
require 'hydramata/works/rubydora_persistence_coordinator'
require 'hydramata/works/conversions/predicate'

module Hydramata
  module Works
    describe RubydoraPersistenceCoordinator do
      include Conversions
      before do
        load Rails.root.join('db/seeds.rb').to_s
      end
      let(:remote_service) { double('RemoteService', call: true) }
      let(:pid_to_mint) { 'hydramata:123' }
      let(:work_type) { 'Article' }
      let(:properties) do
        {
          dc_title: "Example Title",
          dc_abstract: ["Example Abstract", "Another Example"]
        }
      end
      let(:expected_document) do
        {
          "type" => "fobject",
          "pid" => "#{pid_to_mint}",
          "af-model" => "#{work_type}",
          "metadata" => {
            "@context" => { "dc" => "http://purl.org/dc/terms" },
            "dc:title" => ["Example Title"],
            "dc:abstract" => ["Example Abstract", "Another Example"]
          }
        }
      end

      it 'call the underlying remote service passing the expected document' do
        described_class.call(
          { pid: pid_to_mint, work_type: work_type, properties: properties },
          { remote_service: remote_service }
        )
        expect(remote_service).to have_received(:call).with(expected_document)
      end
    end
  end
end
