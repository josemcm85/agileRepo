/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cci.service;

import com.cci.controller.Constantes;
import com.cci.controller.eventWizardViewController;
import com.cci.model.InfoBasica;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Nvidi
 */
public class InfoBasicaDao implements Dao<InfoBasica> {

    private Statement stm;
    private ResultSet rset;
    private PreparedStatement prep;
    private CallableStatement call;

    @Override
    public Optional<InfoBasica> get(long id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<InfoBasica> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void save(InfoBasica t) {
        //
        Conexion conexion = Conexion.getInstance();
        conexion.conectar();
        try {
            System.out.println("" + t.getTags().size());
            call = conexion.conn.prepareCall("{call insert_infoBasica (?,?,?)} ");
            call.setString(1, t.getNombre());
            call.setString(2, t.getTipo());
            call.registerOutParameter(3, Types.INTEGER);

            //stm.execute(String.format("insert into eventopublic (Nombre,finalizado,tipo)  values('%1$s',b'%2$d',(select idTipo from  tiposeventop where tipoEvento = '%3$s' ))", t.getNombre(), 0, t.getTipo()));
            call.execute();
            int idEvt = call.getInt(3);
            System.out.println("IDEVENTO: " + idEvt);
            eventWizardViewController.idEvento = idEvt;

            conexion.conectar();

            for (String s : t.getTags()) {
                stm = conexion.conn.createStatement();
                stm.execute(String.format("Insert into tagsevtpublico  (tag,evento) values('%2$s','%1$d');", idEvt, s));
            }

            //Insert de la descripcion y la vara esa de l organizador qk
            conexion.conectar();

            stm = conexion.conn.createStatement();
            stm.execute(String.format("insert into organizadoreseventos (organizador,evento,descri) values('%1$s','%2$d','%3$s');", Constantes.logguedUsserUID, idEvt, t.getDescripcion()));

            prep = conexion.conn.prepareStatement("update usuarios\n"
                    + "set profileImageP = ?");
            prep.setBlob(1, t.getFoto());
            //prep.execute();

        } catch (SQLException e) {
            System.out.println("" + e.getMessage() + e.getSQLState());
        }

    }

    @Override
    public void update(InfoBasica t) {
        System.out.println("ID del evento : " + eventWizardViewController.idEvento);
        //Update al evento nombre y tipo
        Conexion conne = Conexion.getInstance();
        conne.conectar();
        try {
            stm = conne.conn.createStatement();
            stm.execute(String.format("update eventopublic set nombre = '%2$s', tipo = (select idTipo from tiposeventop where tipoEvento = '%3$s') where idEventoPublic = %1$d;", eventWizardViewController.idEvento, t.getNombre(), t.getTipo()));
            //Eliminar tags y volverlos a crear jsjsjjs
            conne.conectar();
            stm = conne.conn.createStatement();
            stm.execute(String.format("delete from tagsevtpublico where  evento = '%1$d'  ", eventWizardViewController.idEvento));

            for (String tag : t.getTags()) {
                stm = conne.conn.createStatement();
                stm.execute(String.format("Insert into tagsevtpublico (tag,evento) values('%2$s','%1$d') ", eventWizardViewController.idEvento,tag));

            }
            //Update de la descripcion del organizador
            stm = conne.conn.createStatement();
            stm.execute(String.format("Update organizadoreseventos set descri = '%1$s' where evento = '%2$d' ", t.getDescripcion(),eventWizardViewController.idEvento));

        } catch (SQLException ex) {
            Logger.getLogger(InfoBasicaDao.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public void delete(InfoBasica t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
