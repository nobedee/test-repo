# Use an official Perl image as the base
FROM perl:latest

# Install required Perl modules
RUN cpan App::cpanminus
RUN cpanm cgi
RUN cpanm HTML::entities

