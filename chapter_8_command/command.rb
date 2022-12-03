# frozen_string_literal: true

class CreateButton
  attr_accessor :command

  def initialize(&command)
    @command = command
  end

  def execute
    return unless @command

    @command.call
  end
end

CreateButton.new { puts('This is block code') }.execute
