require'libui'
require'./BookStore.rb'

UI = LibUI

UI.init

main_window = UI.new_window('Book Store', 500, 800, 1)
UI.window_on_closing(main_window) do
  UI.control_destroy(main_window)
  UI.quit
  0
end

hbox = UI.new_vertical_box
UI.window_set_child(main_window, hbox)

AddStoreItem = UI.new_button('Add Store Item')
UI.button_on_clicked(AddStoreItem) do
  UI.msg_box(main_window, "Please enter Item details like this format (type,title,price,author name,number of pages,isbn) in the box down below","")
  entry = UI.new_entry
  UI.box_append(hbox, entry, 1)
  button = UI.new_button('Confirm')
  UI.button_on_clicked(button) do
    input = UI.entry_text(entry).to_s
    addItem(input)
    item = input.split(",")
    UI.msg_box(main_window, "You added a "+ item[0].to_s ,""+input)
  end
  UI.box_append(hbox, button, 0)

end
UI.box_append(hbox, AddStoreItem, 1)


ListMostExpensiveItems = UI.new_button('List Most Expensive Items')
UI.button_on_clicked(ListMostExpensiveItems) do
  list = maxPriceItems()
  booklist = list[:books]
  maglist = list[:magazines]
  display = "Books\n\n"
  display += "Title, Price, Author, Pages, ISBN"
  booklist.each{
    |book|
    display += "\n#{book[:title]} #{book[:price]} #{book[:authorName]} #{book[:noOfPages]} #{book[:isbn]}"
  }
  display += "\n\n\nMagazines\n\n"
  display += "Title, Price, Publisher, Date"
  maglist.each{
    |mag|
    display += "\n#{mag[:title]} #{mag[:price]} #{mag[:publisher]} #{mag[:date]}"
  }
  UI.msg_box(main_window, "Most Expensive Items ",display)
end
UI.box_append(hbox, ListMostExpensiveItems, 1)



ListBooksInRange = UI.new_button('List Books IN a Certain Range')
UI.button_on_clicked(ListBooksInRange) do
  UI.msg_box(main_window, "Please enter the range desired as following : From in the first section and To in the second section in the box down below","")
  entry = UI.new_entry
  entry2 = UI.new_entry
  UI.box_append(hbox, entry, 0)
  UI.box_append(hbox, entry2, 0)
  button = UI.new_button('Confirm')
  UI.button_on_clicked(button) do
  input = UI.entry_text(entry).to_s
  input2 = UI.entry_text(entry2).to_s


  list =[]
  list = getRangeOfBooks(input,input2)
  display = "Title, Price, Author, Pages, ISBN"
  list.each{
    |book|
    display += "\n#{book[:title]} #{book[:price]} #{book[:authorName]} #{book[:noOfPages]} #{book[:isbn]}"
  }

  UI.msg_box(main_window, "Books\n" ,display)
  end
  UI.box_append(hbox, button, 0)
end
UI.box_append(hbox, ListBooksInRange, 1)



SearchMagazineByDate = UI.new_button('Search Magazine By Date')
UI.button_on_clicked(SearchMagazineByDate) do
  UI.msg_box(main_window, "Please enter date like this format (DD-MM-YYYY) in the box down below","")
  entry = UI.new_entry
  UI.box_append(hbox, entry, 1)
  button = UI.new_button('Confirm')
  UI.button_on_clicked(button) do
  input = UI.entry_text(entry).to_s
  list = getDateMagazines(input)
  display = "Title, Price, Publisher, Date"
  list.each{
    |mag|
    display += "\n#{mag[:title]} #{mag[:price]} #{mag[:publisher]} #{mag[:date]}"
  }
  if(list.length==0)
    display = "There is no magazines in this day"
  end
  UI.msg_box(main_window, "Magazine in that date", display)
  end
  UI.box_append(hbox, button, 0)
end
UI.box_append(hbox, SearchMagazineByDate, 1)


SearchMagazineByPublisher = UI.new_button('Search Magazine By Publisher')
UI.button_on_clicked(SearchMagazineByPublisher) do
  UI.msg_box(main_window, "Please enter Puplisher agent's name correctly in the box down below","")
  entry = UI.new_entry
  UI.box_append(hbox, entry, 1)
  button = UI.new_button('Confirm')
  UI.button_on_clicked(button) do
  input = UI.entry_text(entry).to_s
  
  list = getPublisherMagazines(input)
  
  display = "Title, Price, Publisher, Date"
  list.each{
    |mag|
    display += "\n#{mag[:title]} #{mag[:price]} #{mag[:publisher]} #{mag[:date]}"
  }
  if(list.length==0)
    display = "There is no magazines by this Puplisher"
  end
  UI.msg_box(main_window, "Magazines ", display)
  end
  UI.box_append(hbox, button, 0)
end
UI.box_append(hbox, SearchMagazineByPublisher, 1)

ListAllStoreItems = UI.new_button('List All Store Items')
UI.button_on_clicked(ListAllStoreItems) do
  list = getAllItems()
  if(list.length==0)
    display = "There is no Items in the store"
  end
  booklist = list[:books]
  maglist = list[:magazines]
  display = "Books\n\n"
  display += "Title, Price, Author, Pages, ISBN"
  booklist.each{
    |book|
    display += "\n#{book[:title]} #{book[:price]} #{book[:authorName]} #{book[:noOfPages]} #{book[:isbn]}"
  }
  display += "\n\n\nMagazines\n\n"
  display += "Title, Price, Publisher, Date"
  maglist.each{
    |mag|
    display += "\n#{mag[:title]} #{mag[:price]} #{mag[:publisher]} #{mag[:date]}"
  }
  UI.msg_box(main_window, "All Items ", display)
end
UI.box_append(hbox, ListAllStoreItems, 1)

DeleteItem = UI.new_button('Delete Item')
UI.button_on_clicked(DeleteItem) do
  UI.msg_box(main_window, "To delete an item please enter type of the item in the first section and in the second section enter title of the item in the box down below","")
  entry = UI.new_entry
  entry2 = UI.new_entry
  UI.box_append(hbox, entry, 0)
  UI.box_append(hbox, entry2, 0)
  button = UI.new_button('Confirm')
  UI.button_on_clicked(button) do
  input = UI.entry_text(entry).to_s
  input2 = UI.entry_text(entry2).to_s
  result = deleteItem(input,input2)

  UI.msg_box(main_window, "Result :" ,""+result.to_s)
  end
  UI.box_append(hbox, button, 0)
end
UI.box_append(hbox, DeleteItem, 1)



UI.control_show(main_window)
UI.main
UI.quit