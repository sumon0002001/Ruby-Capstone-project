# Ruby Capstone Project - Ruby Linter



# About 

The whole idea of writing code to check another code is intriguing at the same time cognitively demanding. 
Building Linters for Ruby, the project provides feedback about errors or warnings in code little by little. 
The project was built completely with Ruby following all possible best practices. Rubocop was used as a code-linter alongside Gitflow to ensure I maintain good coding standards.


# The Build
The custom Ruby linter currently checks/detects for the following errors/warnings.
- check for wrong indentation
- check for trailing white spaces
- check for missing/unexpected tags i.e. '( )', '[ ]', and '{ }'
- check missing/unexpected end
- check empty line error

> Below are demonstrations of good and bad code for the above cases. 

## Indentation Error Check
~~~ruby
# Good Code
module Person
  def initialize(name, live)
    @name = name 
    @live = live
  end

# Bad Code

module Person
  def initialize(name, live)
    @name = name
     @live = live
  end
  end
~~~

## trailing white spaces

~~~ruby
# Good Code

module Person
  def initialize(name, live)
    @name = name
    @live = live
  end
end

# Bad Code

module Person
  def initialize(name, live)
    @name = name
     @live = live
  end
end
~~~

## Missing/Unexpected Tag
~~~ruby
# Good Code

module Person
  def initialize(name, live)
    @name = name
     @live = live
  end
end

# Bad Code

module Person
  def initialize(name, live
    @name = name
     @live =[[live]
  end
end
~~~

## Missing/unexpected end
~~~ruby
# Good Code

module Person
  def initialize(name, live)
    @name = name
     @live = live
  end
end

# Bad Code

module Person
  def initialize(name, live)
    @name = name
     @live = live
  end
  end
end
~~~

## Empty line error
~~~ruby
# Good Code

module Person
  def initialize(name, live)
    @name = name
    @live = live
  end
end

# Bad Code
module Person
  def initialize(name, live)
    
    
    @name = name
    @live = live
  end
end


## Built With
- Ruby
- RSpec for Ruby Testing


# Getting Started

To get a local copy of the repository please run the following commands on your terminal:

```
$ cd <folder>
```

```
$ git clone https://github.com/sumon0002001/Ruby-Capstone-project/tree/feature-branch
```
$ bundle install

**To check for errors on a file:** 

~~~bash
$ bin/main bug.rb
~~~

## Testing

To test the code, run `rspec` from root of the folder using terminal.
Note: `bug.rb` has been excluded from rubocop checks to allow RSpec testing without interfering with Gitflow actions

> Rspec is used for the test, to install the gem file,

> But before that, make sure you have **bundler** installed on your system, else run

~~~bash
$ gem install bundler 
~~~

> or you simply install the the following directly using 

~~~bash
$ gem install rspec 
~~~

~~~bash
$ gem install colorize 
~~~


# Author

👤 **Mir Rawshan Ali**

- Github: [@sumon0002001](https://github.com/sumon0002001)
- Twitter: [@Sumon0002009](https://twitter.com/Sumon0002009)
- Linkedin: [faru-stefen-803364172](https://www.linkedin.com/in/faru-stefen-803364172/)


## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Project inspired by [Microverse](https://www.microverse.org)
