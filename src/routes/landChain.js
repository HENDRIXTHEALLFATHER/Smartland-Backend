import express from "express";
import { landContract } from "../blockchain/landContract.js";
import { ethers } from "ethers";

const router = express.Router();

router.post("/register", async (req, res) => {
  try {
    const { landId, documentHash } = req.body;

    const tx = await landContract.registerLand(landId, documentHash);
    const receipt = await tx.wait();

    res.json({
      message: "Land registered on chain",
      txHash: receipt.hash
    });
  } catch (e) {
    res.status(400).json({ error: e.message });
  }
});

router.get("/:landId", async (req, res) => {
  try {
    const landId = req.params.landId;
    const data = await landContract.getLand(landId);

    res.json({
      landId: data[0].toString(),
      owner: data[1],
      documentHash: data[2]
    });
  } catch (e) {
    res.status(400).json({ error: e.message });
  }
});

router.post("/transfer", async (req, res) => {
  try {
    const { landId, newOwner } = req.body;

    const tx = await landContract.transferLand(landId, newOwner);
    const receipt = await tx.wait();

    res.json({
      message: "Land transferred on chain",
      txHash: receipt.hash
    });
  } catch (e) {
    res.status(400).json({ error: e.message });
  }
});

export default router;