import { connect } from 'react-redux';
import { Action, Dispatch } from 'redux';

import { RootState } from '../redux/reducers/index';
import Todos from './Todos';

const mapStateToProps: (s: RootState) => {} = (state) => {
  return {
  };
};

const mapDispatchToProps: (d: Dispatch<Action>) => {} = (dispatch: Dispatch<Action>) => {
  return {
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Todos);
