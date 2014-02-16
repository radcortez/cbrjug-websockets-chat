package com.cortez.tutorials.websocket;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by radcortez on 10/12/13.
 */
@ServerEndpoint("/chatWebSocket")
public class ChatWebSocket {
    private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet<Session>());

    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
    }

    @OnMessage
    public void onMessage(String message) {
        for (Session session : sessions) {
            session.getAsyncRemote().sendText(message);
        }
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
    }
}
