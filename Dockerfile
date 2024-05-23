# Gebruik de officiële Apache image als basis
FROM httpd:2.4

# Kopieer je eigen index.html naar de standaard documentroot van Apache
COPY index.html /usr/local/apache2/htdocs/

# Exposeer poort 80 om toegang te krijgen tot de Apache-server
EXPOSE 80
