# Gebruik de officiële nginx image als basis
FROM nginx:latest

# Verwijder de standaard index.html van nginx
RUN mkdir -p /home/web

# Kopieer uw eigen index.html naar de juiste locatie
COPY . /index.html

# Start nginx in de voorgrond
CMD ["nginx", "-g", "daemon off;"]
