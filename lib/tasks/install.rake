require 'knapsack_pro'
require 'tty-prompt'

def step_for_rspec(prompt)
  prompt.say "Step for RSpec", color: :red
  prompt.say "Add at the beginning of your spec/spec_helper.rb:"

  prompt.say %{
require 'knapsack_pro'

# CUSTOM_CONFIG_GOES_HERE

KnapsackPro::Adapters::RSpecAdapter.bind
  }, color: :bright_red
end

def step_for_minitest(prompt)
  prompt.say "Step for Minitest", color: :red
  prompt.say "Add at the beginning of your test/test_helper.rb:"

  prompt.say %{
require 'knapsack_pro'

# CUSTOM_CONFIG_GOES_HERE

knapsack_pro_adapter = KnapsackPro::Adapters::MinitestAdapter.bind
knapsack_pro_adapter.set_test_helper_path(__FILE__)
  }, color: :bright_red
end

def step_for_cucumber(prompt)
  prompt.say "Step for Cucumber", color: :red
  prompt.say "Create file features/support/knapsack_pro.rb and add there:"

  prompt.say %{
require 'knapsack_pro'

# CUSTOM_CONFIG_GOES_HERE

KnapsackPro::Adapters::CucumberAdapter.bind
  }, color: :bright_red
end

def step_for_spinach(prompt)
  prompt.say "Step for Spinach", color: :red
  prompt.say "Create file features/support/knapsack_pro.rb and add there:"

  prompt.say %{
require 'knapsack_pro'

# CUSTOM_CONFIG_GOES_HERE

KnapsackPro::Adapters::SpinachAdapter.bind
  }, color: :bright_red
end

namespace :knapsack_pro do
  task :install do
    prompt = TTY::Prompt.new
    answers = {}

    puts
    prompt.say "Welcome in knapsack_pro gem installer.", color: :cyan
    puts
    prompt.say "If you will need to set more custom configuration"
    prompt.say "or would like to better understand how gem works please take a look:"
    prompt.say "https://github.com/KnapsackPro/knapsack_pro-ruby"
    puts

    TESTING_TOOLS_CHOICES = {
      'RSpec' => :rspec,
      'Minitest' => :minitest,
      'Cucumber' => :cucumber,
      'Spinach' => :spinach,
    }
    answers[:testing_tools] = prompt.multi_select("Choose your testing tools:", TESTING_TOOLS_CHOICES)

    answers[:has_vcr] = prompt.yes?('Do you use VCR gem?')

    CI_PROVIDER_CHOICES = {
      'https://circleci.com' => :circle,
      'https://travis-ci.org' => :travis,
      'https://buildkite.com' => :buildkite,
      'https://semaphoreci.com' => :semaphore,
      'https://snap-ci.com' => :snap_ci,
      'other' => :other,
    }
    answers[:ci] = prompt.select("What is your CI provider?", CI_PROVIDER_CHOICES)

    puts

    # Instructions how to set up the gem

    answers[:testing_tools].each do |tool|
      send("step_for_#{tool}", prompt)
      puts
    end
  end
end
