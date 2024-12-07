// this will be changed during production
// Allows for redis connection to port 6380
import { createConsumer } from "@rails/actioncable";

const consumer = createConsumer("ws://localhost:6380/cable");

export default consumer;


