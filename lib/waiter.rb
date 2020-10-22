# ./lib/waiter.rb
class Waiter

  attr_accessor :name, :yrs_experience

  @@all = []

  def initialize(name, yrs_experience)
    @name = name
    @yrs_experience = yrs_experience
    @@all << self
  end

  def self.all
    @@all
  end

  def new_meal(customer, total, tip=0)
    Meal.new(self, customer, total, tip)
  end 

  def meals
    Meal.all.select do |meal|
      meal.waiter == self #checking for waiter now
    end
  end

  def best_tipper
    best_tipped_meal = meals.max do |meal_a, meal_b|
      meal_a.tip <=> meal_b.tip
    end
  
    best_tipped_meal.customer
  end 

  def worst_tipper
    worst_tipped_meal = meals.min do |meal_a, meal_b|
      meal_a.tip <=> meal_b.tip
    end
  
    worst_tipped_meal.customer
  end 

  def most_frequent
    hash = {}
    meals.each do |meal|
      if !hash.has_key?(meal.customer)
        hash[meal.customer] = 1
      else
        hash[meal.customer] += 1
      end
    end
    hash.key(hash.values.max)
  end

  def self.most_experienced_tips
    most_years = 0
    veteran_waiter = nil
    self.all.each do |waiter|
      if waiter.yrs_experience > most_years
        most_years = waiter.yrs_experience
        veteran_waiter = waiter
      end
    end
    sum = 0.0
    veteran_waiter.meals.each do |meal|
      sum += meal.tip
    end
    sum/veteran_waiter.meals.size
  end

  def self.least_experienced_tips
    least_years = 100
    noob_waiter = nil
    self.all.each do |waiter|
      if waiter.yrs_experience < least_years
        least_years = waiter.yrs_experience
        noob_waiter = waiter
      end
    end
    sum = 0.0
    noob_waiter.meals.each do |meal|
      sum += meal.tip
    end
    sum/noob_waiter.meals.size
  end


end 
