import pandas as pd
import numpy as np
from faker import Faker  # Corrected import (was "feker")
from datetime import datetime, timedelta

# Initialize Faker
fake = Faker()  # Corrected class name (was "Eaker")

# Configuration
num_rows = 1000  # Corrected variable name (was "num_pows")
start_date = datetime(2023, 6, 2)  # Corrected syntax (was "year_2023, month: 6, day: 2")
end_date = datetime(2024, 5, 31)  # Corrected syntax

# AI tools and platforms
ai_tools = ['ChatGPT', 'Gemini', 'Copilot', 'DALL-E',
            'Claude']  # Corrected variable name (was "al_tools") and "Gensini"
platforms = ['Twitter', 'Reddit', 'LinkedIn', 'YouTube', 'Instagram']

# Generate dataset
data = []
for _ in range(num_rows):
    # Random date within range
    random_date = start_date + (end_date - start_date) * np.random.random()

    # Generate data
    username = f"@{fake.user_name()}"
    name = fake.name()
    platform = np.random.choice(platforms)
    ai_tool = np.random.choice(ai_tools)
    rating = round(np.random.uniform(1, 5), 1)

    # Generate comment based on rating
    if rating > 4:
        comment = f"{ai_tool} is amazing! {fake.sentence()}"
    elif rating > 3:
        comment = f"I like {ai_tool}. {fake.sentence()}"
    elif rating > 2:
        comment = f"{ai_tool} is okay. {fake.sentence()}"
    else:
        comment = f"Terrible experience with {ai_tool}. {fake.sentence()}"

    data.append([
        username,
        name,
        random_date.strftime('%Y-%m-%d'),
        platform,
        ai_tool,
        rating,
        comment
    ])

# Create DataFrame
df = pd.DataFrame(data, columns=[
    'Username', 'Name', 'Date', 'Platform', 'AI Tool Mentioned',
    'Rating', 'Comment'
])

# Add sentiment category
df['Sentiment'] = pd.cut(df['Rating'],
                         bins=[0, 2, 3, 4, 5],
                         labels=['Negative', 'Neutral', 'Positive', 'Very Positive'])

# Save to Excel
df.to_excel('social_media_sentiment.xlsx', index=False)
print("Dataset successfully generated!")