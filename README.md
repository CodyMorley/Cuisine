# Cuisine
A take home project for Fetch. 

### Summary: Include screen shots or a video of your app highlighting its features

Cuisine uses a sleek, modern interface to guide a user seamlessly through a list of recipes provided by a web host. All images are cached and scrolling is done with no clipping issues. All features support both light and dark appearance modes in iOS.
<img src="https://github.com/user-attachments/assets/e05407c6-b260-482e-bea7-0252130a54b7" width=25% height=25%>
<img src="https://github.com/user-attachments/assets/e1992680-7aa6-4de6-8a4f-162724d6ebd8" width=25% height=25%>

Clicking any recipe brings the user to a simple detail screen with a larger high resoloution image, along with a tag bearing the national origin of the recipe. This screen includes tappable links for both video and written recipes where available. No buttons will appear for unavailable links, reducing user confusion and friction.

<img src="https://github.com/user-attachments/assets/112898ab-944e-4816-8047-e8c0ec54bfde" width=25% height=25%>
<img src="https://github.com/user-attachments/assets/135f87da-d3ab-4c12-83df-0b6f9e6950b5" width=25% height=25%>

Video: 

https://github.com/user-attachments/assets/49e22483-48ce-48aa-b94d-37ab0d3550e3

https://github.com/user-attachments/assets/68b6387b-7aee-4281-a5a0-55e0f2ca3ee8

The app also contains a search feature, allowing to search the whole or partial text of a recipe's name and automatically remove from the the list those recipes with names not containing the search term.


<img src="https://github.com/user-attachments/assets/95db8311-8bc3-45ba-8920-b3dd47065fe6" width=25% height=25%>



### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I prioritized modularity, testability, clean code, and modern best practices in architecture and design patterns. I chose to focus on these areas as despite the project's simplicity these are the touches that give a codebase a professional polish. 

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

This project took approximately 3.5 hours.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

Within the Recipe feature set I chose to swap simplicity for testability in the networking module. I made extensive use of protocol oriented programming here to allow for end to end testing of alternate data scenarios as well as mocking of http responses for unit testing. 

### Weakest Part of the Project: What do you think is the weakest part of your project?

Given more time i'd have come up with a more custom animation for the list to detail presentation than the simple slide animation used in the project. 

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

I apologize for the lateness in turning this project in, I along with my family were displaced by wildfire evacuations this past week. If you have any questions, comments, or feedback please reach out to me at codymorleyinc@gmail.com . Thank you so much for the opportunity, I truly have a passion for iOS and Apple platforms and hope that I can bring that passion to Fetch.
