## How to create the Rails API App

```
# Install rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable

# Install ruby version
rvm install 2.2.6

# Install rails
gem install rails -v 5.1.3

# Create Rails API App
rails new --api notepad-api
cd notepad-api

# Generate Models
rails generate model Note title:string content:string
rails db:migrate

# Run seeds
rails db:seed

# Run server
rails s -p 3001

# Check API
curl -G http://localhost:3001/api/v1/notes
```