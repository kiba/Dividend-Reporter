class Stock < ActiveRecord::Base
  validates :symbol, :presence => true, :length => { :maximum => 5}
  validates_presence_of :company_name
  has_many :quotes, :dependent => :destroy
  has_many :watchlists, :foreign_key => "watched_id"
  has_many :watched, :foreign_key => :watchlists, :source => :watching
  before_save :symbol_upper
  def symbol_upper 
    symbol.upcase!
  end

  def watched? watching 
    watchlists.find_by_watching_id(watching)
  end

end
