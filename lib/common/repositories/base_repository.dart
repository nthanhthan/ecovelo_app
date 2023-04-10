import '../common.dart';
abstract class BaseRepository {
  T getReturnData<T>(T localData, T onlineData){
    if(ObjectUtil.isNotEmpty(onlineData)){
      return onlineData;
    }else{
      return localData;
    }
  }

  StreamData<T> getStreamData<T>(T localData, T onlineData){
    if (onlineData == null && localData == null) {
      return StreamData(data: null, status: StreamStatus.error());
    } else if (ObjectUtil.isEmpty(onlineData!) && ObjectUtil.isEmpty(localData!) ) {
      return StreamData(data: onlineData, status: StreamStatus.empty());
    } else {
      return StreamData(data: getReturnData<T>(localData, onlineData), status: StreamStatus.completed());
    }
  }
}
