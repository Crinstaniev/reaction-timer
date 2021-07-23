import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import dfxJson from "./dfx.json";
import path from "path";
import styleImport from "vite-plugin-style-import";

// List of all aliases for canisters
const aliases = Object.entries(dfxJson.canisters).reduce(
  (acc, [name, _value]) => {
    // Get the network name, or `local` by default.
    const networkName = process.env["DFX_NETWORK"] || "local";
    const outputRoot = path.join(
      __dirname,
      ".dfx",
      networkName,
      "canisters",
      name,
    );

    return {
      ...acc,
      ["dfx-generated/" + name]: path.join(outputRoot, name + ".js"),
    };
  },
  {},
);

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    styleImport({
      libs: [
        {
          libraryName: "element-plus",
          esModule: true,
          ensureStyleFile: true,
          resolveStyle: (name) => {
            return `element-plus/lib/theme-chalk/${name}.css`;
          },
          resolveComponent: (name) => {
            return `element-plus/lib/${name}`;
          },
        },
      ],
    }),
  ],
  resolve: {
    alias: {
      ...aliases,
    },
  },
});
