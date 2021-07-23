import { Actor, HttpAgent } from "@dfinity/agent";
import {
  idlFactory as service_idl,
  canisterId as service_id,
} from "dfx-generated/service";

// DEV
// const agentOptions = {
//   host: "http://localhost:8000",
// }
// const agent = new HttpAgent(agentOptions)

const agent = new HttpAgent();
const service = Actor.createActor(service_idl, {
  agent,
  canisterId: service_id,
});

export { service };
