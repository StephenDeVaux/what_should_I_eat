let homebtn = document.querySelector("#homebtn")
let myrecbtn = document.querySelector("#myrecbtn")
let addrecbtn = document.querySelector("#addrecbtn")
let feedmebtn = document.querySelector("#feedmebtn")
let url = window.location.href

if (url.includes("myrecipes")) {
    myrecbtn.classList.add("selectedbtn")
} else if (url.includes("addrecipe")) {
    addrecbtn.classList.add("selectedbtn")
} else if (url.includes("mealplanner")) {
    feedmebtn.classList.add("selectedbtn")
} else {
    homebtn.classList.add("selectedbtn")
}

categories = ["All", "Mains", "Side", "Dessert", "Starter", "Breakfast", "Snack", "Lunch", "Baking"]
categorybuttons = {};
categories.forEach(function(category) {
    categorybuttons["category"] = document.querySelector("#" + category)
})

// if (url.includes("myrecipes")) {
//     let homebtn = document.querySelector("#homebtn")
// }  else {
//     homebtn.classList.add("selectedbtn")
// }