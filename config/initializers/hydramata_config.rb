Hydramata.configure do |config|
  if ENV['JETTY']
    require 'hydramata/works/rubydora_persistence_coordinator'
    config.work_to_persistence_coordinator = Hydramata::Works::RubydoraPersistenceCoordinator

    require 'hydramata/works/from_persistence/fedora_wrangler'
    config.work_from_persistence_coordinator = ->(options) do
      work = Hydramata::Works::Work.new(identity: options.fetch(:pid))
      Hydramata::Works::FromPersistence::FedoraWrangler.new(work: work).call(work.identity, with_datastreams: true)
      work
    end
  end
end