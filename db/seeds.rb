

Medium.destroy_all
User.destroy_all
Tag.destroy_all
MediumTag.destroy_all
QueuedMedium.destroy_all

User.create(name: "Joey")

Type.create(name: "Book")
Type.create(name: "Tv Show")
Type.create(name: "Movie")
Type.create(name: "Video Game")
Type.create(name: "Podcast")

Tag.create(name: "Horror")
Tag.create(name: "Animated")
Tag.create(name: "Animals")

medium1 = Medium.create(title: "The Conjuring", type: Type.first)
medium2 = Medium.create(title: "Wreck It Ralph", type: Type.third)
medium3 = Medium.create(title: "The Lion King", type: Type.third)
medium4 = Medium.create(title: "The Shining", type: Type.first)
medium5 = Medium.create(title: "The Hungry Caterpillar", type: Type.first)

medium1.tags << Tag.first
medium2.tags << Tag.second
medium3.tags << Tag.second
medium3.tags << Tag.third
medium4.tags << Tag.first
medium5.tags << Tag.third

medium1.users << User.first
medium2.users << User.first
medium3.users << User.first
medium4.users << User.first
medium5.users << User.first
