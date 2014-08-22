# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file .env file.

def within_predicate_set_create_predicate_for_dublin_core(predicate_set, term)
  name = "dc_#{term.gsub('#', '_')}"
  predicate = Hydramata::Works::Predicates::Storage.new(identity: "http://purl.org/dc/terms/#{term}", name_for_application_usage: name)
  predicate.save!
  counter = predicate_set.predicate_presentation_sequences.count + 1
  predicate_set.predicate_presentation_sequences.create!(presentation_sequence: counter, predicate: predicate)
end

['article', 'document'].each do |work_type_name|
  work_type = Hydramata::Works::WorkTypes::Storage.create!(identity: work_type_name, name_for_application_usage: work_type_name)
  predicate_set = Hydramata::Works::PredicateSets::Storage.create!(identity: 'required', work_type: work_type, presentation_sequence: 1, name_for_application_usage: 'required')

  [
    'title',
    'abstract',
  ].each do |term|
    within_predicate_set_create_predicate_for_dublin_core(predicate_set, term)
  end
end
