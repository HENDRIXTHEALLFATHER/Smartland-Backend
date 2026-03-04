import { ethers } from "ethers";
import dotenv from "dotenv";
dotenv.config();

import abi from "./LandRegistryABI.json" assert { type: "json" };

const provider = new ethers.JsonRpcProvider(process.env.AMOY_RPC_URL);
const wallet = new ethers.Wallet(process.env.GOV_PRIVATE_KEY, provider);

export const landContract = new ethers.Contract(
  process.env.LAND_CONTRACT_ADDRESS,
  abi,
  wallet
);