
module Redcar
  class Macro
    attr_reader :actions
    attr_writer :name
    
    def initialize(name, actions, start_in_block_selection_mode)
      @actions = actions.reject {|action| action.is_a?(Redcar::Macros::StartStopRecordingCommand)}
      @name                          = name
      @start_in_block_selection_mode = start_in_block_selection_mode
    end
    
    def name
      @name
    end
    
    def start_in_block_selection_mode?
      @start_in_block_selection_mode
    end
    
    def run
      run_in EditView.focussed_edit_view
    end
    
    def run_in(edit_view)
      Macros.last_run = self
      Macros.last_run_or_recorded = self
      previous_block_selection_mode = edit_view.document.block_selection_mode?
      edit_view.document.block_selection_mode = start_in_block_selection_mode?
      
      Macros::ActionSequence.new(actions, 0).run_in(edit_view)
      
      edit_view.document.block_selection_mode = previous_block_selection_mode
      Redcar.app.repeat_event(:macro_ran)
    end
  end
end
