module Redcar
  class EditView
    module Actions
      class CmdEnterHandler
        def self.handle(edit_view, modifiers)
          return false if Redcar.platform != :osx
          #AutoCompleter::AutoCompleteCommand.new.run
          Redcar::Top::MoveNextLineCommand.new.run
        end
      end
    end
  end
end