set define off
set verify off
set feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
begin wwv_flow.g_import_in_progress := true; end; 
/
 
--       AAAA       PPPPP   EEEEEE  XX      XX
--      AA  AA      PP  PP  EE       XX    XX
--     AA    AA     PP  PP  EE        XX  XX
--    AAAAAAAAAA    PPPPP   EEEE       XXXX
--   AA        AA   PP      EE        XX  XX
--  AA          AA  PP      EE       XX    XX
--  AA          AA  PP      EEEEEE  XX      XX
prompt  Set Credentials...
 
begin
 
  -- Assumes you are running the script connected to SQL*Plus as the Oracle user APEX_040100 or as the owner (parsing schema) of the application.
  wwv_flow_api.set_security_group_id(p_security_group_id=>nvl(wwv_flow_application_install.get_workspace_id,1306414406437536));
 
end;
/

begin wwv_flow.g_import_in_progress := true; end;
/
begin 

select value into wwv_flow_api.g_nls_numeric_chars from nls_session_parameters where parameter='NLS_NUMERIC_CHARACTERS';

end;

/
begin execute immediate 'alter session set nls_numeric_characters=''.,''';

end;

/
begin wwv_flow.g_browser_language := 'en'; end;
/
prompt  Check Compatibility...
 
begin
 
-- This date identifies the minimum version required to import this file.
wwv_flow_api.set_version(p_version_yyyy_mm_dd=>'2011.02.12');
 
end;
/

prompt  Set Application ID...
 
begin
 
   -- SET APPLICATION ID
   wwv_flow.g_flow_id := nvl(wwv_flow_application_install.get_application_id,200);
   wwv_flow_api.g_id_offset := nvl(wwv_flow_application_install.get_offset,0);
null;
 
end;
/

prompt  ...plugins
--
--application/shared_components/plugins/dynamic_action/pretius_apex_enhanced_lov_item_tf
 
begin
 
wwv_flow_api.create_plugin (
  p_id => 9103365018868080 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_type => 'DYNAMIC ACTION'
 ,p_name => 'PRETIUS_APEX_ENHANCED_LOV_ITEM_TF'
 ,p_display_name => 'Pretius APEX Enhanced LOV item - tabular form'
 ,p_category => 'INIT'
 ,p_image_prefix => '#PLUGIN_PREFIX#'
 ,p_plsql_code => 
'function render_plugin ('||unistr('\000a')||
'  p_dynamic_action in apex_plugin.t_dynamic_action,'||unistr('\000a')||
'  p_plugin         in apex_plugin.t_plugin '||unistr('\000a')||
') return apex_plugin.t_dynamic_action_render_result'||unistr('\000a')||
'is'||unistr('\000a')||
'  v_result apex_plugin.t_dynamic_action_render_result;'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
''||unistr('\000a')||
'  apex_javascript.add_library('||unistr('\000a')||
'    p_name      => ''paeli_tf_onload'','||unistr('\000a')||
'    p_directory => p_plugin.file_prefix,'||unistr('\000a')||
'    p_version   => NULL '||unistr('\000a')||
'  );'||unistr('\000a')||
''||unistr('\000a')||
'  apex_css.add_file ('||
'  '||unistr('\000a')||
'    p_name => ''paeli_tf_style'','||unistr('\000a')||
'    p_directory => p_plugin.file_prefix, '||unistr('\000a')||
'    p_version => null'||unistr('\000a')||
'  );'||unistr('\000a')||
''||unistr('\000a')||
'  v_result.ajax_identifier := APEX_PLUGIN.GET_AJAX_IDENTifIER();'||unistr('\000a')||
'  v_result.attribute_01 := p_dynamic_action.attribute_01;'||unistr('\000a')||
'  v_result.attribute_02 := p_dynamic_action.attribute_02;'||unistr('\000a')||
'  v_result.attribute_04 := p_dynamic_action.attribute_04;'||unistr('\000a')||
'  v_result.attribute_05 := p_dynamic_action.attribute_05'||
';'||unistr('\000a')||
'  v_result.attribute_06 := p_dynamic_action.attribute_06;'||unistr('\000a')||
'  v_result.attribute_07 := p_dynamic_action.attribute_07;'||unistr('\000a')||
'  v_result.attribute_08 := p_dynamic_action.attribute_08;'||unistr('\000a')||
'  v_result.attribute_09 := p_dynamic_action.attribute_09;'||unistr('\000a')||
'  v_result.attribute_10 := p_dynamic_action.attribute_10;'||unistr('\000a')||
''||unistr('\000a')||
'  v_result.attribute_10 := p_plugin.attribute_01;'||unistr('\000a')||
''||unistr('\000a')||
'  v_result.javascript_function := '''||unistr('\000a')||
'    function() {'||unistr('\000a')||
'   '||
'   paeli_tabularForm_init(this, ''''''||p_plugin.file_prefix||'''''');'||unistr('\000a')||
'    }'||unistr('\000a')||
'  '';    '||unistr('\000a')||
''||unistr('\000a')||
'  APEX_PLUGIN_UTIL.DEBUG_DYNAMIC_ACTION ('||unistr('\000a')||
'    p_plugin         => p_plugin,'||unistr('\000a')||
'    p_dynamic_action => p_dynamic_action'||unistr('\000a')||
'  );  '||unistr('\000a')||
''||unistr('\000a')||
'  return v_result;'||unistr('\000a')||
''||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'  WHEN OTHERS then'||unistr('\000a')||
'    htp.p( SQLERRM );'||unistr('\000a')||
'    return v_result;'||unistr('\000a')||
'end render_plugin;'||unistr('\000a')||
''
 ,p_render_function => 'render_plugin'
 ,p_substitute_attributes => true
 ,p_version_identifier => '1.0'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 5717836415711143 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 9103365018868080 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 1
 ,p_display_sequence => 10
 ,p_prompt => 'Plugin instances'
 ,p_attribute_type => 'PAGE ITEMS'
 ,p_is_required => true
 ,p_is_translatable => false
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 5718449921715085 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 9103365018868080 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 2
 ,p_display_sequence => 20
 ,p_prompt => 'Column names'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => true
 ,p_is_translatable => false
  );
null;
 
end;
/

 
begin
 
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E7061656C695F74662D636F6E7461696E6572207B0D0A2020202077686974652D73706163653A206E6F777261703B0D0A7D';
null;
 
end;
/

 
begin
 
wwv_flow_api.create_plugin_file (
  p_id => 5690231567101031 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 9103365018868080 + wwv_flow_api.g_id_offset
 ,p_file_name => 'paeli_tf_style.css'
 ,p_mime_type => 'text/css'
 ,p_file_content => wwv_flow_api.g_varchar2_table
  );
null;
 
end;
/

 
begin
 
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '66756E6374696F6E207061656C695F746162756C6172466F726D5F696E6974282064796E616D6963416374696F6E4F626A2C20706C7567696E5F7072656669782029207B0D0A20202F2F636F6E736F6C652E6C6F67282064796E616D6963416374696F6E';
wwv_flow_api.g_varchar2_table(2) := '4F626A20293B0D0A0D0A2020766172200D0A20202020617065785F6465627567203D202478282770646562756727292C0D0A20202020726567696F6E203D2064796E616D6963416374696F6E4F626A2E74726967676572696E67456C656D656E742C200D';
wwv_flow_api.g_varchar2_table(3) := '0A20202020617474723031203D2064796E616D6963416374696F6E4F626A2E616374696F6E2E61747472696275746530312C202F2F706C7567696E206974656D730D0A20202020617474723032203D2064796E616D6963416374696F6E4F626A2E616374';
wwv_flow_api.g_varchar2_table(4) := '696F6E2E61747472696275746530322C202F2F636F6C756D6E206E616D65730D0A20202020636F6C756D6E4E616D6573203D206E756C6C2C0D0A20202020706C7567696E4974656D73203D206E756C6C3B0D0A0D0A202069662028206174747230312021';
wwv_flow_api.g_varchar2_table(5) := '3D206E756C6C2029207B0D0A20202020617474723031203D206174747230312E7265706C616365282F5C732B2F672C202727290D0A20207D0D0A0D0A0D0A2020696620282061747472303220213D206E756C6C2029207B0D0A2020202061747472303220';
wwv_flow_api.g_varchar2_table(6) := '3D206174747230322E7265706C616365282F5C732B2F672C202727290D0A20207D0D0A0D0A0D0A20206966202820617474723031203D3D206E756C6C207C7C206174747230312E6C656E677468203D3D20302029207B0D0A202020207468726F77202750';
wwv_flow_api.g_varchar2_table(7) := '41454C49205446206572726F723A20617474726962757465303120697320656D707479273B0D0A20207D0D0A0D0A20206966202820617474723032203D3D206E756C6C207C7C206174747230322E6C656E677468203D3D20302029207B0D0A2020202074';
wwv_flow_api.g_varchar2_table(8) := '68726F7720275041454C49205446206572726F723A20617474726962757465303220697320656D707479273B0D0A0D0A20207D0D0A0D0A2020696620282021282F5E5B665C645C642E7B302C317D5D2A247C5E665C645C64242F2E746573742820617474';
wwv_flow_api.g_varchar2_table(9) := '7230322029292029207B0D0A202020207468726F7720275041454C49205446206572726F723A20617474726962757465303220697320696E76616C6964206C697374206F6620636F6C756D6E732E2056616C6964206578616D706C653A2022663031222C';
wwv_flow_api.g_varchar2_table(10) := '20226630312C6630322220616E6420736F206F6E2E2E2E273B0D0A20207D0D0A0D0A2020636F6C756D6E4E616D6573203D206174747230322E73706C697428272C27293B0D0A2020706C7567696E4974656D73203D206174747230312E73706C69742827';
wwv_flow_api.g_varchar2_table(11) := '2C27293B0D0A0D0A2020666F7220287661722069203D20303B2069203C20706C7567696E4974656D732E6C656E6774683B20692B2B29207B0D0A0D0A2020202069662028202428202723272B706C7567696E4974656D735B2069205D20292E73697A6528';
wwv_flow_api.g_varchar2_table(12) := '29203D3D20302029207B0D0A2020202020207468726F7720275041454C49205446206572726F723A206974656D205B69643D272B706C7567696E4974656D735B2069205D2B275D206E6F7420666F756E642E273B0D0A0D0A202020207D200D0A0D0A2020';
wwv_flow_api.g_varchar2_table(13) := '202069662028202428202723272B706C7567696E4974656D735B2069205D20292E6174747228276E616D652729203D3D20756E646566696E656429207B0D0A2020202020207468726F7720275041454C49205446206572726F723A206974656D205B6964';
wwv_flow_api.g_varchar2_table(14) := '3D272B706C7567696E4974656D735B2069205D2B275D206973206E6F742041504558206974656D20696E7374616E63652E273B0D0A202020207D0D0A0D0A20202020696620282021617065785F64656275672029207B0D0A20202020202024785F486964';
wwv_flow_api.g_varchar2_table(15) := '654974656D526F772820706C7567696E4974656D735B2069205D20293B0D0A202020202020617065782E6974656D2820706C7567696E4974656D735B2069205D20292E6869646528290D0A202020207D0D0A0D0A20207D0D0A0D0A20202F2F706F646269';
wwv_flow_api.g_varchar2_table(16) := '6E64756A20726567696F6E0D0A202062696E64526567696F6E41522820726567696F6E2C20636F6C756D6E4E616D657320293B0D0A0D0A20202F2F646C61206B617A64656A20706172790D0A2020666F7220287661722069203D303B2069203C20636F6C';
wwv_flow_api.g_varchar2_table(17) := '756D6E4E616D65732E6C656E6774683B20692B2B29207B0D0A20202020646F4D616769632820726567696F6E2C20636F6C756D6E4E616D65735B695D2C20706C7567696E4974656D735B695D20293B0D0A20207D0D0A0D0A20202F2F66756E6B636A6120';
wwv_flow_api.g_varchar2_table(18) := '706F777374616C61206E6120706F74727A656265207465676F2C207A656279207A6177737A65207A6F7374617769616320706C7567696E205041454C492070757374792C207A656279206E6965207573746177696320776172746F736369207720736573';
wwv_flow_api.g_varchar2_table(19) := '6A692061206E61207A616C61646F77616E6965207374726F6E79206E6965207779776F6C61632072657175657374206765744D61736B0D0A202066756E6374696F6E2062696E64526567696F6E41522820705F726567696F6E53656C6563746F722C2070';
wwv_flow_api.g_varchar2_table(20) := '5F636F6C756D6E4E616D65732029207B0D0A2020202066756E6374696F6E20665F736574416C6C4D61736B28652C2064617461297B0D0A2020202020200D0A202020202020766172200D0A202020202020202073656C66203D20242874686973292C0D0A';
wwv_flow_api.g_varchar2_table(21) := '202020202020202076616C756573203D20646174612E76616C7565733B0D0A2020202020200D0A202020202020696620282076616C7565732E6C656E677468203D3D20302029207B0D0A202020202020202072657475726E20766F69642830293B0D0A20';
wwv_flow_api.g_varchar2_table(22) := '20202020207D0D0A0D0A20202020202073656C662E66696E6428275B72657475726E3D272B646174612E636F6C756D6E4E616D652B275D27292E656163682866756E6374696F6E28297B0D0A0D0A2020202020202020766172200D0A2020202020202020';
wwv_flow_api.g_varchar2_table(23) := '2020726F77496E707574203D20242874686973292C0D0A2020202020202020202073686966746564203D2076616C7565732E736869667428293B0D0A0D0A2020202020202020726F77496E7075742E7472696767657228277365744D61736B272C207368';
wwv_flow_api.g_varchar2_table(24) := '6966746564293B0D0A2020202020207D293B0D0A0D0A202020207D0D0A0D0A2020202076617220726567696F6E203D20705F726567696F6E53656C6563746F723B0D0A0D0A20202020242820726567696F6E20292E756E62696E642827736574416C6C4D';
wwv_flow_api.g_varchar2_table(25) := '61736B27293B0D0A20202020242820726567696F6E20292E62696E642827736574416C6C4D61736B272C20665F736574416C6C4D61736B293B0D0A20207D0D0A0D0A202066756E6374696F6E20636C656172506C7567696E496E7374616E63652820705F';
wwv_flow_api.g_varchar2_table(26) := '706C7567696E496E7374616E63652029207B0D0A20202020766172200D0A202020202020706C7567696E203D20705F706C7567696E496E7374616E63652C200D0A2020202020206D61736B203D20705F706C7567696E496E7374616E63652E6E65787441';
wwv_flow_api.g_varchar2_table(27) := '6C6C28272E70616C76325F706C7567696E4D61736B27293B0D0A0D0A20202020706C7567696E2E76616C28206E756C6C20293B0D0A20202020706C7567696E2E706172656E7428292E66696E6428272E70616C76325F69636F6E54726967676572202729';
wwv_flow_api.g_varchar2_table(28) := '2E72656D6F7665417474722827636C61737327292E616464436C617373282770616C76325F69636F6E5472696767657227293B0D0A202020206D61736B2E76616C28206E756C6C20293B0D0A20207D0D0A0D0A202066756E6374696F6E20726566726573';
wwv_flow_api.g_varchar2_table(29) := '6849636F6E732820705F66616B65506C7567696E2C20705F706C7567696E49636F6E732C20705F706C7567696E496E7374616E6365297B0D0A20202020766172200D0A202020202020636C6F6E656449636F6E73203D20705F706C7567696E49636F6E73';
wwv_flow_api.g_varchar2_table(30) := '2E636C6F6E652874727565292C0D0A2020202020207472696767657249636F6E203D202428636C6F6E656449636F6E732E66696E6428272E70616C76325F69636F6E547269676765722729292C0D0A2020202020206C6F6164696E6749636F6E203D2024';
wwv_flow_api.g_varchar2_table(31) := '28636C6F6E656449636F6E732E66696E6428272E70616C76325F69636F6E4C6F616465722729292C0D0A202020202020706173746549636F6E203D202428636C6F6E656449636F6E732E66696E6428272E70616C76325F69636F6E506173746564272929';
wwv_flow_api.g_varchar2_table(32) := '2C0D0A2020202020207472696767657249636F6E436C6F6E6564203D207472696767657249636F6E2E636C6F6E652874727565292C0D0A20202020202066616B65506C7567696E52657475726E203D20705F66616B65506C7567696E2E64617461282772';
wwv_flow_api.g_varchar2_table(33) := '657475726E27293B0D0A0D0A20202020705F66616B65506C7567696E2E6E657874416C6C28272E69636F6E7327292E72656D6F766528293B0D0A0D0A202020207472696767657249636F6E436C6F6E65642E62696E642827636C69636B272C2066756E63';
wwv_flow_api.g_varchar2_table(34) := '74696F6E28297B0D0A202020202020705F706C7567696E496E7374616E63652E76616C282066616B65506C7567696E52657475726E2E76616C282920293B0D0A202020202020705F706C7567696E496E7374616E63652E64617461282774664D61736B27';
wwv_flow_api.g_varchar2_table(35) := '2C20705F66616B65506C7567696E293B0D0A2020202020202F2F7A6F7374617769616D20646C6120737769657465676F2073706F6B6F6A752E2043686F647A69206F20746F2C20C5BC65206B6C696B6E6965636965207720696B6F6E650D0A2020202020';
wwv_flow_api.g_varchar2_table(36) := '202F2F6E696520706F776F64756A65206E6164616E69612074664D61736B2070727A6564206F727967696E616C6E796D2074726967676572656D206E6120636C69636B730D0A20202020202073686F774C6F6164696E672820705F66616B65506C756769';
wwv_flow_api.g_varchar2_table(37) := '6E20293B0D0A0D0A202020207D290D0A0D0A20202020636C6F6E656449636F6E732E617070656E6428207472696767657249636F6E436C6F6E656420293B0D0A0D0A202020207472696767657249636F6E2E72656D6F766528293B0D0A202020200D0A20';
wwv_flow_api.g_varchar2_table(38) := '202020705F66616B65506C7567696E2E64617461287B0D0A202020202020277472696767657249636F6E273A207472696767657249636F6E436C6F6E65642C0D0A202020202020276C6F6164696E6749636F6E273A206C6F6164696E6749636F6E2C0D0A';
wwv_flow_api.g_varchar2_table(39) := '20202020202027706173746549636F6E273A20706173746549636F6E0D0A202020207D292E61667465722820636C6F6E656449636F6E7320293B0D0A0D0A20207D0D0A0D0A202066756E6374696F6E2073686F77547269676765722820656C656D20297B';
wwv_flow_api.g_varchar2_table(40) := '0D0A20202020656C656D2E6461746128277472696767657249636F6E27292E72656D6F7665436C617373282770616C76325F69636F6E48696464656E27293B0D0A20207D3B0D0A0D0A202066756E6374696F6E20686964655472696767657228656C656D';
wwv_flow_api.g_varchar2_table(41) := '297B0D0A20202020656C656D2E6461746128277472696767657249636F6E27292E616464436C617373282770616C76325F69636F6E48696464656E27293B0D0A20207D3B0D0A0D0A202066756E6374696F6E2073686F774C6F6164696E6728656C656D29';
wwv_flow_api.g_varchar2_table(42) := '7B200D0A20202020656C656D2E6461746128276C6F6164696E6749636F6E27292E72656D6F7665436C617373282770616C76325F69636F6E48696464656E27293B0D0A2020202068696465547269676765722820656C656D20293B0D0A20207D3B0D0A0D';
wwv_flow_api.g_varchar2_table(43) := '0A202066756E6374696F6E20686964654C6F6164696E6728656C656D297B200D0A202020202428656C656D292E6461746128276C6F6164696E6749636F6E27292E616464436C617373282770616C76325F69636F6E48696464656E27293B0D0A20202020';
wwv_flow_api.g_varchar2_table(44) := '73686F77547269676765722820656C656D20293B0D0A20207D0D0A0D0A202066756E6374696F6E2073657456616C756573496E64696361746F722820656C656D2029207B0D0A202020200D0A0D0A20202020766172200D0A20202020202073656C66203D';
wwv_flow_api.g_varchar2_table(45) := '20656C656D2C0D0A20202020202068696464656E203D2073656C662E64617461282772657475726E27292C0D0A202020202020696E64696361746F72203D2073656C662E6461746128277472696767657249636F6E27292C0D0A20202020202073657061';
wwv_flow_api.g_varchar2_table(46) := '7261746F72203D202873656C662E646174612827706C7567696E4F7074696F6E732729292E5F736570617261746F722C0D0A20202020202076616C7565734C656E677468203D2068696464656E2E76616C28292E73706C69742820736570617261746F72';
wwv_flow_api.g_varchar2_table(47) := '20292E6C656E6774683B0D0A0D0A20202020696E64696361746F722E72656D6F7665417474722827636C61737327292E616464436C617373282770616C76325F69636F6E5472696767657227293B0D0A0D0A20202020696620282076616C7565734C656E';
wwv_flow_api.g_varchar2_table(48) := '677468203D3D2030207C7C20282076616C7565734C656E677468203D3D20312026262068696464656E2E76616C2829203D3D202727292029207B0D0A20202020202072657475726E20766F69642830293B0D0A202020207D0D0A20202020656C73652069';
wwv_flow_api.g_varchar2_table(49) := '6620282076616C7565734C656E677468203D3D20312029207B0D0A202020202020696E64696361746F722E616464436C617373282770616C76325F69636F6E53696E676C6527293B0D0A202020207D0D0A20202020656C7365207B0D0A20202020202069';
wwv_flow_api.g_varchar2_table(50) := '6E64696361746F722E616464436C617373282770616C76325F69636F6E4D756C7469706C6527293B0D0A202020207D0D0A0D0A20207D0D0A0D0A202066756E6374696F6E20646F4D616769632820705F726567696F6E2C20705F636F6C756D6E4E616D65';
wwv_flow_api.g_varchar2_table(51) := '2C20706C7567696E4974656D2029207B0D0A20202020766172200D0A202020202020636F6C756D6E56616C756573203D206E756C6C2C0D0A2020202020206E756C6C56616C756573203D20302C0D0A202020202020696E707574436F6C756D6E203D2024';
wwv_flow_api.g_varchar2_table(52) := '28275B6E616D653D272B705F636F6C756D6E4E616D652B275D27292C0D0A202020202020706C7567696E496E7374616E6365203D202428275B69643D272B706C7567696E4974656D2B275D27292C0D0A202020202020706C7567696E4D61736B203D206A';
wwv_flow_api.g_varchar2_table(53) := '517565727950414C28275B69643D272B706C7567696E4974656D2B275F444953504C41595D27292C0D0A202020202020706C7567696E49636F6E73203D20706C7567696E496E7374616E63652E6E657874416C6C28272E69636F6E7327292C0D0A202020';
wwv_flow_api.g_varchar2_table(54) := '2020207461626C654F6656616C756573203D205B5D2C0D0A202020202020706C7567696E49636F6E54726967676572203D20706C7567696E496E7374616E63652E6E657874416C6C28272E69636F6E7327292E66696E6428272E70616C76325F69636F6E';
wwv_flow_api.g_varchar2_table(55) := '5472696767657227292C0D0A0D0A20202020202066616B654D61736B203D202428273C696E70757420747970653D22746578742220636C6173733D2266616B654D61736B223E27292C0D0A2020202020207461626C654F6656616C756573203D205B5D2C';
wwv_flow_api.g_varchar2_table(56) := '0D0A202020202020706C7567696E4F7074696F6E73203D20706C7567696E496E7374616E63652E6461746128276F7074696F6E7327293B0D0A0D0A202020202F2F6368616E67650D0A202020202F2F6E6965207A61706F6D6E696A207370726177647A69';
wwv_flow_api.g_varchar2_table(57) := '6320646C61637A65676F2069206F6362207A206368616E67650D0A2020202066616B654D61736B2E62696E6428276368616E6765206B65797570206B6579646F776E206B65797072657373272C2066756E6374696F6E2865297B0D0A2020202020207661';
wwv_flow_api.g_varchar2_table(58) := '722073656C66203D20242874686973293B0D0A0D0A2020202020206966202820652E74797065203D3D20276368616E6765272029207B0D0A0D0A2020202020202020696620282073656C662E76616C28292E6C656E677468203D3D20302029207B0D0A20';
wwv_flow_api.g_varchar2_table(59) := '202020202020202020636C656172506C7567696E496E7374616E63652820706C7567696E496E7374616E636520293B0D0A20202020202020202020706C7567696E496E7374616E63652E7472696767657228276368616E676527293B0D0A0D0A20202020';
wwv_flow_api.g_varchar2_table(60) := '202020207D0D0A202020202020202072657475726E2066616C73653B0D0A2020202020207D0D0A0D0A0D0A202020202020706C7567696E496E7374616E63652E64617461282774664D61736B272C2073656C66293B0D0A0D0A202020202020706C756769';
wwv_flow_api.g_varchar2_table(61) := '6E4D61736B2E76616C2820242874686973292E76616C282920292E7472696767657228206520293B0D0A0D0A202020207D292E62696E6428277365744D61736B272C2066756E6374696F6E28652C2064617461297B0D0A0D0A202020202020766172200D';
wwv_flow_api.g_varchar2_table(62) := '0A202020202020202073656C66203D20242874686973292C0D0A202020202020202068696464656E203D2073656C662E64617461282772657475726E27293B0D0A0D0A20202020202073656C662E72656D6F7665417474722827726561646F6E6C792729';
wwv_flow_api.g_varchar2_table(63) := '3B0D0A20202020202068696464656E2E72656D6F7665417474722827726561646F6E6C7927293B0D0A0D0A202020202020747279207B0D0A202020202020202073656C662E76616C2820646174612E6420293B20200D0A20202020202020202F2F686964';
wwv_flow_api.g_varchar2_table(64) := '64656E2E76616C286E756C6C293B0D0A2020202020207D206361746368286572726F7229207B0D0A202020202020202073656C662E76616C286E756C6C293B0D0A202020202020202068696464656E2E76616C286E756C6C293B0D0A2020202020202020';
wwv_flow_api.g_varchar2_table(65) := '7468726F772027456D707479206F626A6563742076616C75652061667465722072657472696576696E67206D61736B732E204576656E74207365744D61736B3A202227202B6572726F722B2722273B0D0A2020202020207D0D0A2020202020200D0A2020';
wwv_flow_api.g_varchar2_table(66) := '20202020686964654C6F6164696E67282073656C6620293B0D0A20202020202073657456616C756573496E64696361746F72282073656C6620293B0D0A202020207D293B0D0A0D0A20202020706C7567696E496E7374616E63652E756E62696E64280D0A';
wwv_flow_api.g_varchar2_table(67) := '20202020202027706C7567696E5F76616C75655F6368616E67656420706C7567696E5F706F7075705F6F70656E656420706C7567696E5F68656C7065725F706F70656420706C7567696E5F68656C7065725F72656D6F766564207061656C695F69636F6E';
wwv_flow_api.g_varchar2_table(68) := '5F6C6F6164696E675F73686F77207061656C695F69636F6E5F6C6F6164696E675F68696465270D0A0D0A20202020292E62696E6428277061656C695F69636F6E5F6C6F6164696E675F73686F77207061656C695F69636F6E5F6C6F6164696E675F686964';
wwv_flow_api.g_varchar2_table(69) := '65272C2066756E6374696F6E28206520297B0D0A2020202020200D0A2020202020207661722066616B65506C7567696E203D20706C7567696E496E7374616E63652E64617461282774664D61736B27293B0D0A0D0A2020202020206966202866616B6550';
wwv_flow_api.g_varchar2_table(70) := '6C7567696E203D3D20756E646566696E6564207C7C2066616B65506C7567696E203D3D206E756C6C290D0A202020202020202072657475726E20766F69642830293B0D0A0D0A2020202020206966202820652E74797065203D3D20277061656C695F6963';
wwv_flow_api.g_varchar2_table(71) := '6F6E5F6C6F6164696E675F73686F77272029207B0D0A202020202020202073686F774C6F6164696E67282066616B65506C7567696E20293B0D0A2020202020207D0D0A202020202020656C7365206966202820652E74797065203D3D20277061656C695F';
wwv_flow_api.g_varchar2_table(72) := '69636F6E5F6C6F6164696E675F68696465272029207B0D0A2020202020202020686964654C6F6164696E67282066616B65506C7567696E20293B0D0A2020202020207D0D0A0D0A202020207D292E62696E642827706C7567696E5F76616C75655F636861';
wwv_flow_api.g_varchar2_table(73) := '6E676564272C2066756E6374696F6E28297B0D0A202020202020766172200D0A202020202020202073656C66203D20242874686973292C0D0A202020202020202066616B65506C7567696E4D61736B203D2073656C662E6461746128202774664D61736B';
wwv_flow_api.g_varchar2_table(74) := '2720292C0D0A202020202020202066616B65506C7567696E52657475726E203D2066616B65506C7567696E4D61736B2E70726576416C6C28272E66616B65506C7567696E52657475726E27293B0D0A0D0A20202020202066616B65506C7567696E4D6173';
wwv_flow_api.g_varchar2_table(75) := '6B2E76616C2820706C7567696E4D61736B2E76616C282920292E666F63757328293B0D0A20202020202066616B65506C7567696E52657475726E2E76616C282073656C662E76616C282920293B0D0A20202020202073656C662E64617461282774664D61';
wwv_flow_api.g_varchar2_table(76) := '736B272C206E756C6C293B0D0A2020202020207265667265736849636F6E73282066616B65506C7567696E4D61736B2C20706C7567696E49636F6E732C2073656C6620293B0D0A202020202020636C656172506C7567696E496E7374616E636528207365';
wwv_flow_api.g_varchar2_table(77) := '6C6620293B0D0A0D0A202020207D292E62696E642827706C7567696E5F706F7075705F6F70656E6564272C2066756E6374696F6E28297B0D0A2020202020207661722073656C66203D20242874686973293B0D0A0D0A202020207D292E62696E64282770';
wwv_flow_api.g_varchar2_table(78) := '6C7567696E5F68656C7065725F706F706564272C2066756E6374696F6E28652C2064617461297B0D0A202020202020766172200D0A202020202020202068656C706572203D202428646174612E5041454C492E6D61736B2E68656C706572292C0D0A2020';
wwv_flow_api.g_varchar2_table(79) := '20202020202066616B65506C7567696E203D20706C7567696E496E7374616E63652E64617461282774664D61736B27293B0D0A0D0A20202020202068656C7065722E637373287B0D0A2020202020202020276D61782D7769647468273A20282428646F63';
wwv_flow_api.g_varchar2_table(80) := '756D656E74292E776964746828292D66616B65506C7567696E2E6F666673657428292E6C656674292A302E392C0D0A2020202020202020276D696E2D7769647468273A2066616B65506C7567696E2E6F75746572576964746828292C20200D0A20202020';
wwv_flow_api.g_varchar2_table(81) := '2020202027746F70273A2066616B65506C7567696E2E6F666673657428292E746F702B66616B65506C7567696E2E6F7574657248656967687428292C0D0A2020202020202020276C656674273A2066616B65506C7567696E2E6F666673657428292E6C65';
wwv_flow_api.g_varchar2_table(82) := '66740D0A2020202020207D292020202020200D0A0D0A202020207D292E62696E642827706C7567696E5F68656C7065725F72656D6F766564272C2066756E6374696F6E28297B0D0A2020202020206E756C6C3B0D0A202020207D292E62696E642827706C';
wwv_flow_api.g_varchar2_table(83) := '7567696E5F706F7075705F636C6F7365272C2066756E6374696F6E28297B0D0A2020202020207661722073656C66203D20242874686973293B0D0A20202020202073656C662E64617461282774664D61736B272C206E756C6C293B0D0A2020202020200D';
wwv_flow_api.g_varchar2_table(84) := '0A202020207D292E62696E642827706C7567696E5F706F7075705F636C6F73655F62746E272C2066756E6374696F6E28297B0D0A2020202020206E756C6C3B0D0A202020207D293B0D0A0D0A0D0A202020202F2F646C61206B617A6465676F2077696572';
wwv_flow_api.g_varchar2_table(85) := '737A6120772072616D616368206A65646E656A206B6F6C756D6E790D0A20202020696E707574436F6C756D6E2E656163682866756E6374696F6E28297B0D0A202020202020766172200D0A202020202020202073656C66203D20242874686973292C0D0A';
wwv_flow_api.g_varchar2_table(86) := '2020202020202020726F775F66616B654D61736B203D2066616B654D61736B2E636C6F6E652874727565292C0D0A2020202020202020666972737456616C7565203D202873656C662E76616C2829292E73706C69742820706C7567696E4F7074696F6E73';
wwv_flow_api.g_varchar2_table(87) := '2E5F736570617261746F7220295B305D2C0D0A2020202020202020706172656E74203D2073656C662E636C6F736573742827746427292C0D0A202020202020202073656C66436C6F6E6564203D2073656C662E636C6F6E652874727565292C0D0A202020';
wwv_flow_api.g_varchar2_table(88) := '2020202020636F6E7461696E6572203D202428273C64697620636C6173733D227061656C695F74662D636F6E7461696E6572223E3C2F6469763E27293B0D0A0D0A202020202020706172656E742E617070656E642820636F6E7461696E657220290D0A20';
wwv_flow_api.g_varchar2_table(89) := '202020202073656C662E617070656E64546F2820636F6E7461696E657220293B0D0A0D0A202020202020726F775F66616B654D61736B2E64617461287B0D0A20202020202020202772657475726E273A2073656C662C0D0A202020202020202027706C75';
wwv_flow_api.g_varchar2_table(90) := '67696E4F7074696F6E73273A20706C7567696E4F7074696F6E730D0A2020202020207D292E61747472287B0D0A20202020202020202772657475726E273A2073656C662E6174747228276E616D6527292C0D0A202020202020202027726561646F6E6C79';
wwv_flow_api.g_varchar2_table(91) := '273A2027726561646F6E6C79270D0A2020202020207D292E76616C282073656C662E76616C282920293B0D0A0D0A20202020202073656C662E61667465722820726F775F66616B654D61736B20293B0D0A0D0A2020202020207265667265736849636F6E';
wwv_flow_api.g_varchar2_table(92) := '732820726F775F66616B654D61736B2C20706C7567696E49636F6E732C20706C7567696E496E7374616E6365293B0D0A0D0A2020202020206966202821617065785F6465627567290D0A202020202020202073656C662E637373287B0D0A202020202020';
wwv_flow_api.g_varchar2_table(93) := '2020202027646973706C6179273A20276E6F6E65270D0A20202020202020207D293B0D0A202020202020656C73650D0A202020202020202073656C662E637373287B0D0A20202020202020202020276D617267696E2D7269676874273A2027357078272C';
wwv_flow_api.g_varchar2_table(94) := '0D0A2020202020202020202027626F72646572273A202731707820736F6C696420726564270D0A20202020202020207D293B0D0A0D0A20202020202073656C662E61747472287B0D0A202020202020202027636C617373273A202766616B65506C756769';
wwv_flow_api.g_varchar2_table(95) := '6E52657475726E272C0D0A202020202020202027726561646F6E6C79273A2027726561646F6E6C79270D0A2020202020207D293B0D0A0D0A2020202020206966202820666972737456616C75652E6C656E677468203E203029207B0D0A20202020202020';
wwv_flow_api.g_varchar2_table(96) := '207461626C654F6656616C7565732E707573682820666972737456616C756520293B0D0A202020202020202073686F774C6F6164696E672820726F775F66616B654D61736B20293B0D0A2020202020207D0D0A202020202020656C7365207B0D0A202020';
wwv_flow_api.g_varchar2_table(97) := '20202020207461626C654F6656616C7565732E7075736828206E756C6C20293B0D0A20202020202020206E756C6C56616C7565732B2B3B0D0A2020202020207D0D0A0D0A202020207D293B0D0A0D0A20202020636F6C756D6E56616C756573203D207461';
wwv_flow_api.g_varchar2_table(98) := '626C654F6656616C7565732E6A6F696E2820706C7567696E4F7074696F6E732E5F736570617261746F7220293B0D0A0D0A202020206966202820636F6C756D6E56616C7565732E6C656E677468203D3D2030207C7C206E756C6C56616C756573203D3D20';
wwv_flow_api.g_varchar2_table(99) := '7461626C654F6656616C7565732E6C656E67746829207B0D0A2020202020202428275B72657475726E3D272B705F636F6C756D6E4E616D652B275D27292E72656D6F7665417474722827726561646F6E6C7927293B0D0A202020207D20656C7365207B0D';
wwv_flow_api.g_varchar2_table(100) := '0A202020202020706C7567696E496E7374616E63652E74726967676572282027676574416C6C4D61736B272C207B2776616C756573273A20636F6C756D6E56616C7565732C2027726567696F6E273A20705F726567696F6E2C2027636F6C756D6E4E616D';
wwv_flow_api.g_varchar2_table(101) := '65273A20705F636F6C756D6E4E616D65207D20293B202020200D0A202020207D0D0A20207D0D0A7D2020';
null;
 
end;
/

 
begin
 
wwv_flow_api.create_plugin_file (
  p_id => 5808942300503593 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 9103365018868080 + wwv_flow_api.g_id_offset
 ,p_file_name => 'paeli_tf_onload.js'
 ,p_mime_type => 'application/javascript'
 ,p_file_content => wwv_flow_api.g_varchar2_table
  );
null;
 
end;
/

commit;
begin 
execute immediate 'begin dbms_session.set_nls( param => ''NLS_NUMERIC_CHARACTERS'', value => '''''''' || replace(wwv_flow_api.g_nls_numeric_chars,'''''''','''''''''''') || ''''''''); end;';
end;
/
set verify on
set feedback on
set define on
prompt  ...done
