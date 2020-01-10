# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Property.create({house_number: "31",
                 street: "Marienburger Straße",
                 city: "Berlin",
                 zip_code: "10405",
                 state: "Berlin",
                 lat: 52.534993,
                 lng: 13.4211476,
                 price: 350000
                })

Property.create({house_number: "16",
                 street: "Winsstraße",
                 city: "Berlin",
                 zip_code: "10405",
                 state: "Berlin",
                 lat: 52.533533,
                 lng: 13.425226,
                 price: 320400})

Property.create({house_number: "17",
                 street: "Winsstrasse",
                 city: "Berlin",
                 zip_code: "10407",
                 state: "Berlin",
                 lat: 52.523199,
                 lng: 13.334668,
                 price: 320555})
