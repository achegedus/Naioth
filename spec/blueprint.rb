require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.email          { Faker::Internet.email }
Sham.first_name     { Faker::Name.first_name }
Sham.last_name      { Faker::Name.last_name }
Sham.company        { Faker::Company.name }
Sham.address1       { Faker::Address.street_address }
Sham.city           { Faker::Address.city }
Sham.state          { Faker::Address.us_state_abbr }
Sham.country        { "US" }
Sham.zipcode        { Faker::Address.zip_code }
Sham.phone          { Faker::PhoneNumber.phone_number }
Sham.login          { Faker::Internet.user_name }
Sham.description    { Faker::Lorem.words(4) }

Account.blueprint do
  login         { Sham.login }
  password      { "ASDAWOIJEWCJL" }
  password_confirmation { "ASDAWOIJEWCJL" }
end

Account.blueprint(:signup) do
  login         { Sham.login }
  password      { "ASDAWOIJEWCJL" }
  password_confirmation { "ASDAWOIJEWCJL" }
end

ContactType.blueprint do
  name          { "Billing" }
end

Contact.blueprint do
  account       { Account.make }
  first_name    { Sham.first_name }
  last_name     { Sham.last_name }
  email         { Sham.email }
  company       { Sham.company }
  contact_type  { ContactType.make }
  address1      { Sham.address1 }
  city          { Sham.city }
  state         { Sham.state }
  zip           { Sham.zipcode }
  phone         { Sham.phone }
  country       { "US" }
end

SystemPreferences.blueprint do
  key           { "Test" }
  value         { 25 }
end

Invoice.blueprint do
  account       { Account.make }
  invoice_number { "1231231" }
  date          { Date.today }
  url           { "http://www.yahoo.com" }
  external      { "3fwej32er" }
  state         { "created" }
  cost          { 0 }
end


LineItem.blueprint do
  invoice       { Invoice.make }
  description   { Sham.description }
  cost          { 2000 }
end

Plan.blueprint do
  description   { Sham.description }
  code          { Faker::Lorem.words(1) }
  cost          { 1000 }
end

BillableItemType.blueprint do
  name          {"Flat fee"}
end

BillableItem.blueprint do
  billable_item_type { BillableItemType.make }
  name          { Faker::Lorem.words(1) }
  description   { Faker::Lorem.words(4) }
end

PlanItem.blueprint do
  plan          { Plan.make }
  billable_item { BillableItem.make }
end