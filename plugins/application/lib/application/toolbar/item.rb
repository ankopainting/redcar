
module Redcar
  class ToolBar
    class Item
      class Separator < Item
        def initialize(options={})
          super(nil, options)
        end
        
        def is_unique?
          true
        end
      end

      attr_reader :text, :command, :priority, :value, :icon, :barname
 
      # Create a new Item, with the given text to display in the toolbar, and
      # either:
      #   the Redcar::Command that is run when the item is selected.
      #   or a block to run when the item is selected
      def initialize(text, options={}, &block)
        @text = text
        
        if options.respond_to?('[]')
          @command = options[:command] || block
	        @priority = options[:priority] # Currently not utilized
          @value = options[:value]
          @icon = options[:icon]
          @barname = options[:barname]
        # This branch is for compatibility with old code. Please use :command 
        # option in new code
        # FIXME: Should this be removed at some point?
        else
          @command = options || block
        end
        
        @priority ||= ToolBar::DEFAULT_PRIORITY
      end
      
      # Call this to signal that the toolbar item has been selected by the user.
      def selected(with_key=false)
        if @value
          @command.new.run(:value => @value)
        else  
          @command.new.run#(:with_key => with_key)
        end
      end
      
      def type
        @type
      end
      
      def type
        @type
      end
      
      def merge(other)
        @command = other.command
        @priority = other.priority
      end
      
      def ==(other)
        text == other.text and command == other.command
      end
      
      def is_unique?
        false
      end
    end
  end
end
