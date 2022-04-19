import { Web3Provider } from "@components/providers";

const BaseLayout = ({ children }) => {
  return (
    <Web3Provider>
      <div className="body-content">{children}</div>
    </Web3Provider>
  );
};

export default BaseLayout;
