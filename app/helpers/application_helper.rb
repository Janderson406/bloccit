module ApplicationHelper

  def form_group_tag(errors, &block)
       css_class = 'form-group'
       css_class << ' has-error' if errors.any?
        #form_group_tag takes two arguments. The first argument is an array of errors, and the second is a block.
        #The & turns the block into a Proc, which we've seen before but haven't named. A Proc is a block that can be reused like a variable.
       content_tag :div, capture(&block), class: css_class
        #content_tag helper method is used to build the HTML and CSS to display the form element and any associated errors.
        #It takes a symbol argument, a block, and an options hash. It then creates the symbol-specified
        #HTML tag with the block contents, and if specified, the options.
     end

end
