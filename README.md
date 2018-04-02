# Household Management

A tool for managing household bills, chores, needs and inventory.

## Installation

This application uses Facebook OAuth, which requires a FACEBOOK_KEY/FACEBOOK_SECRET in /config/application.yml to sign-up/login using Facebook. The rest of the application functions normally without this, including standard sign-up/login.
To try out this application, run the following from the command-line:
```
  $ git clone https://github.com/blinded93/household_management
  $ cd household_management
  $ bundle install
  $ rake db:migrate
  $ rails s
```
Then navigate to the IP address displayed.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/blinded93/household_management.

## Authors

* [**Kyle Hughes** ](https://github.com/blinded93)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
