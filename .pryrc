# frozen_string_literal: true

require 'tangled'

Pry.config.commands.import(Pry::CommandSet.new do
  command 'reload!', 'Reload Pry' do
    target.eval <<-EVAL
      at_exit { puts "Reloading pry..."; exec "pry" }
      exit
    EVAL
  end

  alias_command 'r', 'reload!'
end)
