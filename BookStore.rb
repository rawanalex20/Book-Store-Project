class StoreItem
    @@countItems = 0
    @@itemId = 0
    @@allitems = []
    attr_accessor :title, :price, :itemId
    def initialize(title, price)
        @title = title
        @price = price.to_f
        @@countItems += 1
        @@itemId += 1
        @@allitems << self
        return @@itemId
    end

    def self.Count
        @@countItems
    end

    def delete(id)
        item = @@allitems.select {|item| item.itemId == id}
        @@allitems.delete(item[0])
        @@countItems -= 1
    end

    def display
        "(Title :#@title, Price :#@price)"
    end
end


class Book < StoreItem
    @@count = 0
    @@allbooks = []
    attr_accessor :authorName, :noOfPages, :isbn
    def initialize(item)
        @@itemId = super(item[:title], item[:price])
        @authorName = item[:authorName]
        @noOfPages = item[:noOfPages].to_i
        @isbn = item[:isbn]
        @@count += 1
        @@allbooks << self
    end

    def self.count
        @@count
    end

    def self.all
        @@allbooks
    end

    def self.select(title)
        selected = nil
        @@allbooks.each {
            |book| 
            if book.title == title
                selected = book 
            end}
        return selected
    end

    def delete
        @@allbooks.delete(self)
        @@count -= 1
        super(@@itemId)
    end

    def display
        string = "(Title :#@title, Price :#@price,NumberOfPages :#@noOfPages)"
        string += "(AuthorName :#@authorName , isbn : #@isbn)"
        return string
    end
end


class Magazine < StoreItem
    @@count = 0
    @@allMagazines = []
    attr_accessor :puplisherAgent, :date
    def initialize(item)
        @@itemId = super(item[:title], item[:price])
        @puplisherAgent = item[:puplisherAgent]
        @date = item[:date]
        @@count += 1
        @@allMagazines << self
    end

    def self.count
        @@count
    end

    def self.all
        @@allMagazines
    end

    def self.select(title)
        selected = nil
        @@allMagazines.each {
            |magazine| 
            if magazine.title == title 
                selected = magazine 
            end
        }
        return selected
    end

    def delete
        @@allMagazines.delete(self)
        @@count -= 1
        super(@@itemId)
    end

    def display
       string = "(Title :#@title, Price :#@price,"
       string += "(PuplisherAgent :#@puplisherAgent, Date :#@date)"
       return string
    end
end



#Reading From Files
file = File.open("./Books.txt")
file_data = File.read(file).split("\n")

file_data.each{
    |data|
    book = data.split(",")
    new_book = {
        :title => book[0],
        :price => book[1],
        :authorName => book[2],
        :noOfPages => book[3],
        :isbn => book[4]
    }
    Book.new(new_book)
}
file = File.close()

file = File.open("./Magazines.txt")
file_data = File.read(file).split("\n")

file_data.each{
    |data|
    magazine = data.split(",")
    new_magazine = {
        :title => magazine[0],
        :price => magazine[1],
        :puplisherAgent => magazine[2],
        :date => magazine[3]
    }
    Magazine.new(new_magazine)
}

file = File.close()
# METHODS

# Method Add item



def addItem(itemItself)
    item = itemItself.split(",")
    if item[0] == "Book"
        
        new_book = {
            :title => item[1],
            :price => item[2],
            :authorName => item[3],
            :noOfPages => item[4],
            :isbn => item[5]
        }
        Book.new(new_book)
        
    else
        new_magazine = {
            :title => item[1],
            :price => item[2],
            :puplisherAgent => item[3],
            :date => item[4]
        }
        Magazine.new(new_magazine)
    end
end



# List most expensive items
def maxPriceItems
    maxbook = 0
    maxmag = 0

    # Searching for max
    books = Book.all
    books.each{
        |book|
        if book.price > maxbook
            maxbook = book.price
        end
    }
    magaziness = Magazine.all
    magaziness.each{
        |mag|
        if mag.price > maxmag
            maxmag = mag.price
        end
    }
    
    # Put the maximum prices 
    booklist = []
    books.each{
        |book|
        if book.price == maxbook
            item = {
                :title => book.title,
                :price => book.price,
                :authorName => book.authorName,
                :noOfPages => book.noOfPages,
                :isbn => book.isbn
            }
            booklist << item
        end
    }
    maglist = []
    magaziness.each{
        |mag|
        if mag.price == maxmag
            item = {
                :title => mag.title,
                :price => mag.price,
                :publisher => mag.puplisherAgent,
                :date => mag.date,
            }
            maglist << item
        end
    }

    list = {
        :books => booklist,
        :magazines => maglist
    }
    return list
end


def getRangeOfBooks (from, to)
    from = from.to_f
    to = to.to_f
    books = Book.all
    list = []
    books.each{
        |book|
        if book.price >= from && book.price <= to
            item = {
                :title => book.title,
                :price => book.price,
                :authorName => book.authorName,
                :noOfPages => book.noOfPages,
                :isbn => book.isbn
            }
            list << item
        end
    }
    return list
end


def getDateMagazines(date)
    magazines = Magazine.all
    list = []
    magazines.each{
        |mag|
        if mag.date == date
            item = {
                :title => mag.title,
                :price => mag.price,
                :publisher => mag.puplisherAgent,
                :date => mag.date,
            }
            list << item
        end
    }
    return list
end


def getPublisherMagazines(publisher)
    magazines = Magazine.all
    list = []
    magazines.each{
        |mag|
        if mag.puplisherAgent == publisher
            item = {
                :title => mag.title,
                :price => mag.price,
                :publisher => mag.puplisherAgent,
                :date => mag.date,
            }
            list << item
        end
    }
    
    return list
end


def getAllItems
    books = Book.all
    magazines = Magazine.all
    booklist = []
    books.each{
        |book|
        item = {
            :title => book.title,
            :price => book.price,
            :authorName => book.authorName,
            :noOfPages => book.noOfPages,
            :isbn => book.isbn
        }
        booklist << item
    }
    maglist = []
    magazines.each{
        |mag|
        item = {
            :title => mag.title,
            :price => mag.price,
            :publisher => mag.puplisherAgent,
            :date => mag.date,
        }
        maglist << item
    }
    
    items = {
        :books => booklist,
        :magazines => maglist
    }
    return items
end


def deleteItem(type, title)
    item = nil
    if type == "Book"
        item = Book.select(title)
    elsif type == "Magazine"
        item = Magazine.select(title)
    end
    if item == nil
        return "Error No Such a name like this"
    else
        item.delete
        return "Deleted"
    end
end