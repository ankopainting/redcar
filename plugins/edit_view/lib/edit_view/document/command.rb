module Redcar
  class DocumentCommand < Command
    sensitize :edit_view_focussed
    
    def _finished
      edit_view.history.record(self)
    end
    
    def run_in_focussed_tab_edit_view
      if edit_view = Redcar::EditView.focussed_tab_edit_view
        run(:env => {:edit_view => edit_view})
      end
    end
    
    private
    
    def edit_view
      env[:edit_view] || EditView.focussed_edit_view
    end
    
    def doc
      edit_view.document
    end
  end
end