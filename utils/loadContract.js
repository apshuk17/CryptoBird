const NETWORK_ID = process.env.NEXT_PUBLIC_NETWORK_ID;

export const loadContract = async ({contractName, web3}) => {
  let contract;
  try {
    const response = await fetch(`/contracts/${contractName}.json`);
    const Artifact = await response.json();

    contract = new web3.eth.Contract(
      Artifact.abi,
      Artifact.networks[NETWORK_ID].address
    );
  } catch (err) {
    console.error("Error in loading the contract", error);
  } finally {
    return contract;
  }
};
