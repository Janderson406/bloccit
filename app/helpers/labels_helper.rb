module LabelsHelper
  def labels_to_buttons(labels)
    raw labels.map { |l| link_to l.name, label_path(id: l.id), class: 'btn-xs btn-primary' }.join(' ')
  end
end

#map iterates over the labels array for each item in the array.
#map creates a link (using link_to) to each label path using label_path(id: l.id).
#The link is displayed as l.name (the first parameter passed to link_to) and is styled by the third parameter to link_to, class: 'btn-xs btn-primary'.
#We then join each of these HTML generated links and separate them with a space using .join(' ').

#The output of labels.map{ ... will look like the following:
# <a class="btn-xs btn-primary" href="/labels/1">L1</a> <a class="btn-xs btn-primary" href="/labels/2">L2</a>

#'raw' tells Ruby to call map without escaping the string that is returned.
#Often times strings must be escaped because they contain special characters in them that
#the parser will confuse as part of the program. Escaping a character in a string
#is typically done by prepending the character that needs to be escaped with a \.
#If we were to not use raw then ruby would escape the output of labels.map which would
#result in broken links and funny characters showing up in Bloccit.
