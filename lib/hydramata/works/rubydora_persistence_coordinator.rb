require 'hydramata/works/conversions/predicate'

module Hydramata
  module Works
    # Responsible for gathering input properties into their respected format
    # and sending them along to the #remote_service.
    class RubydoraPersistenceCoordinator
      include Conversions
      def self.call(attributes = {}, collaborators = {})
        new(attributes, collaborators).call
      end

      attr_reader :pid, :work_type, :properties, :remote_service
      private :pid, :work_type, :properties, :remote_service
      def initialize(attributes = {}, collaborators = {})
        @pid = attributes.fetch(:pid)
        @work_type = attributes.fetch(:work_type)
        @properties = attributes.fetch(:properties)
        @remote_service = collaborators.fetch(:remote_service) { default_remote_service }
      end

      def call
        remote_service.call(work_document)
      end

      private

      def work_document
        @work_document ||= apply_properties_to(base_work_payload)
      end

      def base_work_payload
        {
          "type" => "fobject",
          "pid" => "#{pid}",
          "af-model" => "#{work_type}"
        }
      end

      def apply_properties_to(payload)
        properties.each do |key, values|
          predicate = Predicate(key)
          datastream_name =
            ( predicate.datastream_name == 'descMetadata' ? 'metadata' : predicate.datastream_name )
          payload[datastream_name] ||= {}
          payload[datastream_name]["@context"] ||= {}
          payload[datastream_name]["@context"][predicate.namespace_context_prefix] = predicate.namespace_context_url
          payload[datastream_name][predicate.namespace_context_name] = Array.wrap(values)
        end
        payload
      end

      def default_remote_service
        require 'rof'
        ->(document) { ROF.Ingest(document, Hydramata.configuration.repository_connection) }
      end
    end
  end
end
