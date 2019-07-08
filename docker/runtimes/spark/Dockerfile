FROM rmuresano/bdaaspython:0_0_4 as builder
WORKDIR /home/legacy
COPY packages/ ./


FROM rmuresano/bdaaspython:0_0_4 
WORKDIR /home/legacy
COPY --from=builder /home/legacy/spark /home/legacy/spark
COPY --from=builder /home/legacy/hadoop /home/legacy/hadoop


#I have to include the jar dependencies
