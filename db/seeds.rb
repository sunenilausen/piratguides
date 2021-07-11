# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(email: "admin@example.com", password: "administrator", admin: true)
User.create(email: "volunteer@example.com", password: "volunteer", volunteer: true)
User.create(email: "translator@example.com", password: "translator", translator: true)
level = Level.create(title: "Beginner")
tool = Tool.create(title: "Unity 3D")
language = Language.create(title: "Python")
subject = Subject.create(title: "Games")
lecture = Lecture.create(title: "Test Lecture", number: 1, body: "Lecture Body", author: admin, active: true, tools: [tool], level: level, subjects: [subject], languages: [language], community: false)
article = Article.create(title: "Test Article", key: "test-article", body: "Article Body", active: true)
ArticleLectureInsertion.create(article: article, lecture: lecture, number: 0)
Lecture.create(title: "Community Lecture", number: 1, body: "Lecture Body", author: admin, active: true, tools: [tool], level: level, subjects: [subject], languages: [language], community: true)
