class Author < MotionData::ManagedObject
end

class Article < MotionData::ManagedObject
end

class Citation < MotionData::ManagedObject
end

class Author
  hasMany :articles, :destinationEntity => Article.entityDescription, :inverse => :author

  property :name, String, :required => true
  property :fee, Float
end

class Article
  hasOne :author, :destinationEntity => Author.entityDescription, :inverse => :articles
  hasMany :citation, :destinationEntity => Citation.entityDescription, :inverse => :article

  property :title,     String,  :required => true
  property :body,      String,  :required => true
  property :published, Boolean, :default  => false
  property :publishedAt, Time, :default  => false

  scope :published, where(:published => true)
  scope :withTitle, where( value(:title) != nil ).sortBy(:title, ascending:false)

#  scope :latestCitation, where( "timeStamp=citation.@max.timeStamp" ).sortBy(:timeStamp, ascending:true)
end

class Citation
  hasOne :article, :destinationEntity => Article.entityDescription, :inverse => :citation

  property :title,      String, :required => true
  property :timeStamp,  Time,   :default => false
  property :favorite,   Boolean, :default => false

  scope :publication, where( value(:title) != nil ).sortBy(:title, ascending:true)
end
