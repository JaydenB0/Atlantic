// Put all the API handling here, so we can import it from webpack-dev-server
import { Router } from "express";
import { ExpressPeerServer } from 'peer';

const debug = process.env.NODE_ENV == "development";

const router = new Router();

ExpressPeerServer(router, {
    debug,
    path: '/test'
  })

router.get("/", (req, res)=>{
    res.send("HI!!!");
});

export default router;