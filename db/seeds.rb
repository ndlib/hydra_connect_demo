# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file .env file.

predicate_depositor = Hydramata::Works::Predicates::Storage.create!(identity: 'depositor')
predicate_title = Hydramata::Works::Predicates::Storage.create!(
  identity: 'http://purl.org/dc/terms/title',
  namespace_context_name: 'dc:title',
  namespace_context_prefix: 'dc',
  namespace_context_url: 'http://purl.org/dc/terms/',
  name_for_application_usage: 'dc_title',
  value_parser_name: 'InterrogationParser',
  datastream_name: 'descMetadata',
  validations: '{ "presence_of_each": true }'
)
predicate_attachment = Hydramata::Works::Predicates::Storage.create!(
  identity: 'opaque:file',
  name_for_application_usage: 'file',
  view_path_fragment: 'attachment',
  value_parser_name: 'AttachmentParser',
  value_presenter_class_name: 'AttachmentPresenter'
)
predicate_abstract = Hydramata::Works::Predicates::Storage.create!(
  identity: 'http://purl.org/dc/terms/abstract',
  namespace_context_prefix: 'dc',
  namespace_context_name: 'dc:abstract',
  namespace_context_url: 'http://purl.org/dc/terms/',
  name_for_application_usage: 'dc_abstract',
  value_parser_name: 'InterrogationParser',
  datastream_name: 'descMetadata'
)

predicate_contributor = Hydramata::Works::Predicates::Storage.create!(
  identity: 'http://purl.org/dc/terms/contributor',
  namespace_context_name: 'dc:contributor',
  namespace_context_prefix: 'dc',
  namespace_context_url: 'http://purl.org/dc/terms/',
  name_for_application_usage: 'dc_contributor',
  value_parser_name: 'Contributor',
  datastream_name: 'descMetadata'
)

predicate_created = Hydramata::Works::Predicates::Storage.create!(identity: 'http://purl.org/dc/terms/created', name_for_application_usage: 'dc_created', value_parser_name: 'DateParser')

predicate_language = Hydramata::Works::Predicates::Storage.create!(identity: 'http://purl.org/dc/terms/language', name_for_application_usage: 'dc_language', value_parser_name: 'InterrogationParser' )
predicate_publicher = Hydramata::Works::Predicates::Storage.create!(identity: 'http://purl.org/dc/terms/publisher', name_for_application_usage: 'dc_publisher', value_parser_name: 'InterrogationParser')
predicate_dateSubmitted = Hydramata::Works::Predicates::Storage.create!(identity: 'http://purl.org/dc/terms/dateSubmitted', name_for_application_usage: 'dc_dateSubmitted', value_parser_name: 'DateParser')
predicate_modified = Hydramata::Works::Predicates::Storage.create!(identity: 'http://purl.org/dc/terms/modified', name_for_application_usage: 'dc_modified', value_parser_name: 'DateParser')
predicate_rights = Hydramata::Works::Predicates::Storage.create!(identity: 'http://purl.org/dc/terms/rights', name_for_application_usage: 'dc_rights', value_parser_name: 'InterrogationParser')

['document', 'article'].each do |identifier|
  work_type = Hydramata::Works::WorkTypes::Storage.create(identity: identifier, name_for_application_usage: identifier)
  predicate_set = Hydramata::Works::PredicateSets::Storage.create!(identity: 'required', work_type: work_type, presentation_sequence: 1, name_for_application_usage: 'required')
  predicate_set.predicate_presentation_sequences.create!(presentation_sequence: 1, predicate: predicate_title)

  optional_predicate_set = Hydramata::Works::PredicateSets::Storage.create!(identity: 'optional', work_type: work_type, presentation_sequence: 2, name_for_application_usage: 'optional')
  optional_predicate_set.predicate_presentation_sequences.create!(presentation_sequence: 1, predicate: predicate_abstract)
  optional_predicate_set.predicate_presentation_sequences.create!(presentation_sequence: 2, predicate: predicate_contributor)
  optional_predicate_set.predicate_presentation_sequences.create!(presentation_sequence: 3, predicate: predicate_attachment)
end
