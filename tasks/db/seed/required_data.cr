require "../../../spec/support/factories/**"

# Add seeds here that are *required* for your app to work.
# For example, you might need at least one admin user or you might need at least
# one category for your blog posts for the app to work.
#
# Use `Db::Seed::SampleData` if your only want to add sample data helpful for
# development.
class Db::Seed::RequiredData < LuckyTask::Task
  summary "Add database records required for the app to work"

  def call
    # Using a Avram::Factory:
    #
    # Use the defaults, but override just the email
    # UserFactory.create &.email("me@example.com")

    # Using a SaveOperation:
    #
    # SaveUser.create!(email: "me@example.com", name: "Jane")
    #
    # You likely want to be able to run this file more than once. To do that,
    # only create the record if it doesn't exist yet:
    #
    # unless UserQuery.new.email("me@example.com").first?
    #  SaveUser.create!(email: "me@example.com", name: "Jane")
    # end

    unless CustomerQuery.new.name("Bewise").first?
      SaveCustomer.create!(
        name: "Bewise",
        status: "activated",
        description:"Bewise Technology"
      )
    end

    unless UserQuery.new.email("wayahead@bewise.dev").first?
      customer = CustomerQuery.new.name("Bewise").first?
      if customer
        SaveUser.create!(
          email: "wayahead@bewise.dev",
          encrypted_password: Authentic.generate_encrypted_password(%q<@NqGaKv*237+>),
          name: "wayahead",
          status: "activated",
          roles: ["superuser"],
          description: "super administrator",
          customer_id: customer.id
        )
      end
    end

    puts "Done adding required data"
  end
end
