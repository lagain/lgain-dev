const counter = document.querySelector(".counter");

async function updateCounter() {
    let response = await fetch("https://isyvq245oc.execute-api.us-east-1.amazonaws.com/prod", {method: "POST"});
    let data = await response.json();
    counter.innerHTML = `${data}`;
}

updateCounter();