RUN addgroup -g 1000 -S $GROUP \
    && adduser -u 1000 -S ruby -G ruby


El siguiente paso es copiar el Etc Password de la imagen resultante

COPY --from=base /etc/passwd /etc/passwd

Y en el final antes de iniciar el proceso se llama a 
USER ruby 