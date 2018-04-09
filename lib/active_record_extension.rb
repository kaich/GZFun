module ActiveRecordExtension

  extend ActiveSupport::Concern



  # add your static(class) methods here
  class_methods do
    #search 
    def search_by(name,search)
      if search
        where(["#{name} LIKE ?", "%#{search}%"])
      else
        all 
      end
    end
  end
end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)
