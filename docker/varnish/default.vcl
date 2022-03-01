vcl 4.0;

backend default {
    .host = "gocustomized-m2.local";
    .port = "8080";
    .first_byte_timeout = 300s;
}