# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
        I used Ruby on Rails.
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)
        Households have many bills, members and rooms. Items have many room_items, rooms, list_items and lists. Lists have many list_items and items. Members have many chores and messages, as received and sent messages. Rooms have many room_items and items.
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
        Bills belong to households. Chores belong to members. List_items belong to lists and items. Lists belong to members. Members belong to a household. Messages belong to members, as a recipient and a sender. Room_items belong to rooms and items. Rooms can belong to a member and/or a household.
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
        Rooms have many items through room_items.  Lists have many items through list_items.  Items have many lists and rooms through list_items and room_items.
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
        List_items have quantity, brand and info attributes.
        Room_items have stock, request(boolean) and reorder threshold attributes.
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
        Mostly presence of attributes, a few uniquness and a few custom protecting from invalid data.
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
        Many scope methods in chores/bills referring to the due_date attribute. A couple in rooms, room_items, messages and lists.
- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)
        Room_item and list_item forms have nested item models in the forms.  It can create or find the specified item.
- [x] Include signup (how e.g. Devise)
        Custom sigup using the session hash.
- [x] Include login (how e.g. Devise)
        Custom login using a session controller and hash.
- [x] Include logout (how e.g. Devise)
        Custom logout deleting info from the sessions hash using the session controller.
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
        Facebook login.
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
        Two separate nested resources, households (admin) and members pages.
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
        All nested RESTful routes included.
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
        All forms display red border around affected fields and validation errors at the bottom.

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
