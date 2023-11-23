if @rating.persisted?
  json.form render(partial: "ratings/form", formats: :html, locals: {rating: Rating.new, recipe: @recipe})
  json.inserted_item render(partial: "ratings/rating", formats: :html, locals: {rating: @rating})
else
  json.form render(partial: "rating/form", formats: :html, locals: {rating: @rating, recipe: @recipe})
end
