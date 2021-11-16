### Backend Coding Exercise
**Comments**
- "Your program should also accept a “Bill me on” date and a dollar amount."
  - Not sure if the requirement is to implement a background work that would process the transaction on the bill me on date. 
- "Write an audit function to show payouts and transactions that make up a given payout."
  - A given payout it made up of transactions but not other payouts.
---

#### Installation

- Bundle

```ruby
bundle install
```

- Yarn
  - node version 14 was used 
```ruby
yarn install
```

- Create database, migrate and seed

```ruby
rails db:create
rails db:migrate
rails db:seed
```

#### Running


```ruby
rails server
```

[Localhost](http://localhost:3000)


#### Testing


- Seed database

```ruby
rails db:test:prepare
rails db:seed RAILS_ENV=test
```

- run test

```ruby
rspec
```