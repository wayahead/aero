require "../../../spec/support/factories/**"

# Add sample data helpful for development, e.g. (fake users, blog posts, etc.)
#
# Use `Db::Seed::RequiredData` if you need to create data *required* for your
# app to work.
class Db::Seed::SampleData < LuckyTask::Task
  summary "Add sample database records helpful for development"

  def call
    # Using an Avram::Factory:
    #
    # Use the defaults, but override just the email
    # UserFactory.create &.email("me@example.com")

    # Using a SaveOperation:
    # ```
    # SignUpUser.create!(email: "me@example.com", password: "test123", password_confirmation: "test123")
    # ```
    #
    # You likely want to be able to run this file more than once. To do that,
    # only create the record if it doesn't exist yet:
    # ```
    # if UserQuery.new.email("me@example.com").none?
    #   SignUpUser.create!(email: "me@example.com", password: "test123", password_confirmation: "test123")
    # end
    # ```

    unless CustomerQuery.new.name("Bewise").first?
      SaveCustomer.create!(
        name: "Bewise",
        status: "activated",
        description:"Bewise Technology"
      )
    end

    unless CustomerQuery.new.name("TopEase").first?
      SaveCustomer.create!(
        name: "TopEase",
        status: "activated",
        description:"TopEase Technology"
      )
    end

    unless UserQuery.new.email("wayahead@bewise.dev").first?
      customer = CustomerQuery.new.name("Bewise").first?
      if customer
        SaveUser.create!(
          email: "bewise@bewise.dev",
          encrypted_password: Authentic.generate_encrypted_password(%q<@NqGaKv*237+>),
          name: "bewise",
          status: "activated",
          roles: ["superuser"],
          description: "super administrator of Bewise",
          customer_id: customer.id
        )
      end

      customer = CustomerQuery.new.name("TopEase").first?
      if customer
        SaveUser.create!(
          email: "topease@topease.com",
          encrypted_password: Authentic.generate_encrypted_password(%q<@NqGaKv*237+>),
          name: "topease",
          status: "activated",
          roles: ["superuser"],
          description: "super administrator of TopEase",
          customer_id: customer.id
        )
      end
    end

    puts "Done adding sample data"
  end
end
