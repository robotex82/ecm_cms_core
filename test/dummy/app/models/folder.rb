class Folder < ActiveRecord::Base
  has_many :templates, :dependent => :destroy
  
  validates :basename, :presence => true, :uniqueness => { :scope => :parent_id }
  
  acts_as_nested_set :depth_column => 'depth', :counter_cache => :children_count
  attr_protected :lft, :rgt  
  
  before_validation :update_path
  after_save :update_children,  :if => Proc.new { |folder| folder.pathname_changed? or folder.basename_changed? }
  after_save :update_templates, :if => Proc.new { |folder| folder.pathname_changed? or folder.basename_changed? }
  
  default_scope order(:lft)  
  
  def to_s
    self.fullname
    # self.tree_label
  end
  
  def tree_label
    "#{'&#160;&#160;&#160;&#160;' * self.level} |--#{self.basename}".html_safe
  end
  
  def fullname
    if self.basename == "/"
      "/"
    else
      "#{self.pathname}#{self.basename}/"
    end
  end 
  
  def update_path
    if self.parent
      self.pathname = self.parent.fullname
    end
  end
  
  def update_path!
    self.update_path
    self.save
  end
  
  def update_children
    self.children.each do |folder|
      folder.update_path!
    end
  end
  
  def update_templates
    self.templates.each do |template|
      template.update_pathname!
    end
  end  
end
